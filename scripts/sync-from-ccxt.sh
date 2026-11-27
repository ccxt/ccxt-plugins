#!/usr/bin/env bash
# Copies the skills from a ccxt/ccxt checkout into the plugins here. ccxt/ccxt is the source of
# truth for every SKILL.md; this repository only publishes copies. Manifests, READMEs and icons
# are maintained here and are not touched.
#
#   scripts/sync-from-ccxt.sh <path to a ccxt/ccxt checkout>
#
# The checkout needs .claude/skills, .agents/skills (some skills there are symlinks into it) and
# mcp/hosted/plugin; a sparse checkout of those works.
#
# Fails on anything unexpected (a missing source, a skill without frontmatter, a symlink leaving
# the checkout), so a broken source turns the sync red instead of silently syncing nothing. The
# one exception: while ccxt/ccxt master has no mcp/hosted/plugin at all (before ccxt/ccxt#31384
# is merged) it exits 0 without changing anything, so an older master never overwrites newer
# copies. Once the hosted plugin is there, a missing hosted skill is an error like any other.
set -euo pipefail

SRC="${1:?usage: sync-from-ccxt.sh <ccxt checkout>}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
[ -d "$SRC/.claude/skills" ] || { echo "::error::$SRC/.claude/skills not found: not a ccxt/ccxt checkout?"; exit 1; }
SRC_REAL="$(cd "$SRC" && pwd -P)"

# The skills each plugin ships. A fixed list: a skill renamed or removed upstream fails the sync
# (missing SKILL.md) until this list is updated, rather than disappearing from a plugin.
CODING_SKILLS="ccxt-typescript ccxt-python ccxt-php ccxt-csharp ccxt-go ccxt-java ccxt-rust ccxt-cli"

if [ ! -d "$SRC/mcp/hosted/plugin" ]; then
    echo "::notice::$SRC has no mcp/hosted/plugin yet (ccxt/ccxt#31384 not merged); nothing synced"
    exit 0
fi
HOSTED_SKILL="$SRC/mcp/hosted/plugin/skills/ccxt"

TMPDIRS=()
cleanup() { [ "${#TMPDIRS[@]}" -eq 0 ] || rm -rf "${TMPDIRS[@]}"; }
trap cleanup EXIT

# a SKILL.md must open with a closed frontmatter block whose name is the skill's name and that
# has a description; no symlink in the skill may point outside the ccxt checkout
check_skill() {   # check_skill <name> <dir>
    local name="$1" dir="$2" f="$2/SKILL.md"
    [ -f "$f" ] || { echo "::error::missing $f"; exit 1; }
    head -1 "$f" | grep -qx -- '---' || { echo "::error::$f does not start with frontmatter"; exit 1; }
    local front
    front="$(awk 'NR == 1 { next } /^---$/ { closed = 1; exit } { print } END { if (!closed) exit 1 }' "$f")" \
        || { echo "::error::$f: frontmatter is not closed"; exit 1; }
    printf '%s\n' "$front" | grep -qx "name: *$name" || { echo "::error::$f: frontmatter name is not \"$name\""; exit 1; }
    printf '%s\n' "$front" | grep -q '^description:' || { echo "::error::$f: frontmatter has no description"; exit 1; }
    local link target
    while IFS= read -r link; do
        target="$(python3 -c 'import os, sys; p = os.path.realpath(sys.argv[1]); print(p) if os.path.exists(p) else sys.exit(1)' "$link")" \
            || { echo "::error::$link is a dangling symlink"; exit 1; }
        case "$target" in
            "$SRC_REAL"/*) ;;
            *) echo "::error::$link points outside the ccxt checkout ($target)"; exit 1 ;;
        esac
    done < <([ -L "$dir" ] && echo "$dir"; find -H "$dir" -type l)
}

# build <plugin>/skills aside with exactly the listed skills; nothing is replaced until every
# plugin's set has been built and checked
STAGED=()
stage() {   # stage <plugin dir> <name=source dir>...
    local plugin="$1"; shift
    local tmp; tmp="$(mktemp -d)"; TMPDIRS+=("$tmp")
    local pair name from
    for pair in "$@"; do
        name="${pair%%=*}"; from="${pair#*=}"
        check_skill "$name" "$from"
        # -L: copy what a symlink points at; the published copy holds real files
        cp -RL "$from" "$tmp/$name"
    done
    chmod 755 "$tmp"
    STAGED+=("$plugin=$tmp")
}

main_skills=("ccxt=$HOSTED_SKILL")
for s in $CODING_SKILLS; do main_skills+=("$s=$SRC/.claude/skills/$s"); done

stage claude/ccxt "${main_skills[@]}"
stage chatgpt/ccxt "${main_skills[@]}"
stage claude/ccxt-local "ccxt-mcp=$SRC/.claude/skills/ccxt-mcp"

for pair in "${STAGED[@]}"; do
    dest="$ROOT/${pair%%=*}/skills"
    rm -rf "$dest"
    mv "${pair#*=}" "$dest"
done

echo "synced from $SRC"
