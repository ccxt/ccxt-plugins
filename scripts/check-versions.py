"""Fail when a plugin's files changed since <base> but its version was not raised above <base>'s.

    python3 scripts/check-versions.py <base commit>

Claude Code only updates an installed plugin when its version changes, so a change shipped
under an old version never reaches the people who installed it.
"""
import json
import re
import subprocess
import sys

PLUGINS = {
    'claude/ccxt': 'claude/ccxt/.claude-plugin/plugin.json',
    'claude/ccxt-local': 'claude/ccxt-local/.claude-plugin/plugin.json',
    'chatgpt/ccxt': 'chatgpt/ccxt/plugin.json',
}


def git(*args):
    return subprocess.run(['git', *args], check=True, capture_output=True, text=True).stdout


def version_tuple(version, where):
    match = re.fullmatch(r'(\d+)\.(\d+)\.(\d+)', version or '')
    if not match:
        sys.exit(f'{where}: version {version!r} is not x.y.z')
    return tuple(int(x) for x in match.groups())


base = sys.argv[1]
failed = False
for directory, manifest in PLUGINS.items():
    if not git('diff', '--name-only', base, 'HEAD', '--', directory).strip():
        continue
    try:
        before = json.loads(git('show', f'{base}:{manifest}')).get('version')
    except subprocess.CalledProcessError:
        print(f'{directory}: new plugin')
        continue
    after = json.load(open(manifest)).get('version')
    if version_tuple(after, manifest) <= version_tuple(before, f'{base}:{manifest}'):
        print(f'::error file={manifest}::{directory} changed but its version stayed {after} '
              f'(main has {before}); raise it, e.g. python3 scripts/bump-version.py {manifest}')
        failed = True
    else:
        print(f'{directory}: {before} -> {after}')
sys.exit(1 if failed else 0)
