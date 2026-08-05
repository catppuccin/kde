#!/bin/sh
# name-list provenance: install.sh's hardcoded numbered flavour/accent menus must
# resolve to the same names, in the same order, as the catppuccin crate (via
# whiskers). Extracted from install.sh itself, not hand-copied, so a future menu
# edit that drifts from the crate fails here rather than shipping silently.
#
# whiskers-dependent, unlike the rest of the black-box suite: needs a whiskers
# binary on PATH (or WHISKERS=/path/to/whiskers). Not part of tests/run.sh.
set -eu
cd "$(dirname "$0")/.."

WHISKERS="${WHISKERS:-whiskers}"
command -v "$WHISKERS" >/dev/null 2>&1 || {
    echo "provenance: '$WHISKERS' not found; set WHISKERS=/path/to/whiskers" >&2
    exit 1
}

fail=0

extract_names() {
    var=$1
    grep -oE "^[[:space:]]*[0-9]+\\) ${var}=\"[A-Za-z]+\"" install.sh |
        sed -E 's/^[[:space:]]*([0-9]+)\) '"$var"'="([A-Za-z]+)"/\1 \2/' |
        sort -n -k1,1 |
        awk '{print tolower($2)}'
}

# accent order is 1:1 between install.sh's menu and the crate's own order.
installer_accents=$(extract_names ACCENTNAME)
whiskers_accents=$("$WHISKERS" --list-accents -o plain)
if [ "$installer_accents" = "$whiskers_accents" ]; then
    echo "provenance: ok (14 accents, install.sh order matches whiskers --list-accents)"
else
    echo "provenance: accent order mismatch between install.sh and whiskers --list-accents" >&2
    echo "  install.sh: $(printf '%s' "$installer_accents" | tr '\n' ' ')" >&2
    echo "  whiskers:   $(printf '%s' "$whiskers_accents" | tr '\n' ' ')" >&2
    fail=1
fi

# flavour order is the exact reverse: the crate lists light-to-dark (latte first),
# install.sh's menu is the historical dark-to-light, Mocha-first order.
installer_flavours=$(extract_names FLAVOURNAME)
whiskers_flavours_reversed=$("$WHISKERS" --list-flavors -o plain | awk '{a[NR]=$0} END {for(i=NR;i>=1;i--) print a[i]}')
if [ "$installer_flavours" = "$whiskers_flavours_reversed" ]; then
    echo "provenance: ok (4 flavours, install.sh order matches whiskers --list-flavors reversed)"
else
    echo "provenance: flavour order mismatch between install.sh and whiskers --list-flavors (reversed)" >&2
    echo "  install.sh:          $(printf '%s' "$installer_flavours" | tr '\n' ' ')" >&2
    echo "  whiskers (reversed): $(printf '%s' "$whiskers_flavours_reversed" | tr '\n' ' ')" >&2
    fail=1
fi

# templates/canonical-palette.tera hardcodes its flavour iteration order
# (deliberately: it matches the historical Mocha-first order, not the crate's
# light-to-dark order) instead of iterating whiskers' own flavour data, so
# cross-check its SET of flavours (order doesn't matter here) against whiskers
# -- a hypothetical new upstream flavour would otherwise be silently dropped
# from canonical-palette.txt with nothing else to catch it.
template_flavours=$(grep -oE 'for name in \[.*\]' templates/canonical-palette.tera | grep -oE '"\w+"' | tr -d '"' | sort)
whiskers_flavours_sorted=$("$WHISKERS" --list-flavors -o plain | sort)
if [ "$template_flavours" = "$whiskers_flavours_sorted" ]; then
    echo "provenance: ok (canonical-palette.tera's flavour set matches whiskers --list-flavors)"
else
    echo "provenance: canonical-palette.tera's hardcoded flavour list doesn't match whiskers --list-flavors" >&2
    echo "  template:  $(printf '%s' "$template_flavours" | tr '\n' ' ')" >&2
    echo "  whiskers:  $(printf '%s' "$whiskers_flavours_sorted" | tr '\n' ' ')" >&2
    fail=1
fi

exit "$fail"
