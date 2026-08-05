#!/bin/sh
# drift guard: whiskers --check every templates/*.tera against its committed
# generated/ output. single-output templates (no matrix: key, e.g.
# canonical-palette.tera) need an explicit example path; multi-output
# templates reject one.
#
# shared between justfile's check recipe (pinned .bin/whiskers, for
# contributors) and ci.yml's whiskers-drift job (PATH whiskers via
# setup-whiskers, the org-standard auto-detecting action) -- those two
# intentionally use different binary sources, only the detection logic
# is common. set WHISKERS to the binary path; defaults to PATH lookup.
set -eu
cd "$(dirname "$0")/.."

WHISKERS="${WHISKERS:-whiskers}"
command -v "$WHISKERS" >/dev/null 2>&1 || {
    echo "whiskers-check: '$WHISKERS' not found; set WHISKERS=/path/to/whiskers" >&2
    exit 1
}

if [ -d templates ] && [ -n "$(find templates -maxdepth 1 -name '*.tera' -print -quit)" ]; then
    for f in templates/*.tera; do
        if grep -q '^[[:space:]]*matrix:' "$f"; then
            "$WHISKERS" "$f" --check
        else
            example=$(sed -n 's/^[[:space:]]*filename:[[:space:]]*"\(.*\)"[[:space:]]*$/\1/p' "$f" | head -n1)
            "$WHISKERS" "$f" --check "$example"
        fi
    done
else
    echo "No templates/*.tera found yet; nothing to check." >&2
fi
