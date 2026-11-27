#!/usr/bin/env bash
# Copies the skills from a ccxt/ccxt checkout into the plugins here. ccxt/ccxt is the source of
# truth for every SKILL.md; this repository only publishes copies. Manifests, READMEs and icons
# are written here and are not touched.
#
#   scripts/sync-from-ccxt.sh <path to a ccxt/ccxt checkout>
#
# The checkout needs only .claude/skills and mcp/hosted/plugin/skills (a sparse checkout works).
# Exit 0 with nothing changed when the source does not have the hosted plugin yet (before
# ccxt/ccxt#31384 is on master), so an older master never overwrites newer copies.
set -euo pipefail

SRC="${1:?usage: sync-from-ccxt.sh <ccxt checkout>}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# the CCXT library coding skills, bundled with the main `ccxt` plugin
CODING_SKILLS="ccxt-typescript ccxt-python ccxt-php ccxt-csharp ccxt-go ccxt-java ccxt-rust ccxt-cli"

HOSTED_SKILL="$SRC/mcp/hosted/plugin/skills/ccxt"
if [ ! -f "$HOSTED_SKILL/SKILL.md" ]; then
    echo "::notice::$SRC has no mcp/hosted/plugin/skills/ccxt yet; nothing synced"
    exit 0
fi

check_skill() {   # a SKILL.md must start with frontmatter that has name and description
    local f="$1/SKILL.md"
    [ -f "$f" ] || { echo "::error::missing $f"; exit 1; }
    head -1 "$f" | grep -qx -- '---' || { echo "::error::$f has no frontmatter"; exit 1; }
    awk 'NR>1 && /^---$/ {exit} {print}' "$f" | grep -q '^name:' || { echo "::error::$f has no name"; exit 1; }
    awk 'NR>1 && /^---$/ {exit} {print}' "$f" | grep -q '^description:' || { echo "::error::$f has no description"; exit 1; }
}

# replace <dest>/skills with exactly the listed skills (so a skill removed upstream goes here too)
publish() {   # publish <plugin dir> <name=source dir>...
    local dest="$ROOT/$1/skills"; shift
    local tmp; tmp="$(mktemp -d)"
    for pair in "$@"; do
        local name="${pair%%=*}" from="${pair#*=}"
        check_skill "$from"
        # -L: copy what a symlink points at; the published copy holds real files
        cp -RL "$from" "$tmp/$name"
    done
    rm -rf "$dest"
    mkdir -p "$(dirname "$dest")"
    mv "$tmp" "$dest"
    chmod 755 "$dest"
}

main_skills=("ccxt=$HOSTED_SKILL")
for s in $CODING_SKILLS; do main_skills+=("$s=$SRC/.claude/skills/$s"); done

publish claude/ccxt "${main_skills[@]}"
publish chatgpt/ccxt "${main_skills[@]}"
publish claude/ccxt-local "ccxt-mcp=$SRC/.claude/skills/ccxt-mcp"

echo "synced from $SRC"
