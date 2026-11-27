"""Raise the patch number of a plugin manifest's "version" (x.y.z -> x.y.z+1), keeping key order."""
import json
import re
import sys

path = sys.argv[1]
with open(path) as f:
    manifest = json.load(f)
match = re.fullmatch(r'(\d+)\.(\d+)\.(\d+)', str(manifest.get('version', '')))
if not match:
    sys.exit(f"{path}: version {manifest.get('version')!r} is not x.y.z; set it by hand")
major, minor, patch = (int(x) for x in match.groups())
manifest['version'] = f'{major}.{minor}.{patch + 1}'
with open(path, 'w') as f:
    f.write(json.dumps(manifest, indent=2, ensure_ascii=False) + '\n')
print(path, manifest['version'])
