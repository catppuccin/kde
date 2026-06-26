#!/bin/sh
# regenerate the committed fixtures (golden outputs + canonical palette snapshot)
# by driving the installer entry point. run this when output changes on purpose,
# then review and commit the diff. tests/run.sh runs this and git-diffs the result.
set -eu
libdir=$(dirname "$0")
# shellcheck source=tests/lib.sh
. "$libdir/lib.sh"

GOLD=tests/goldens
mkdir -p "$GOLD" "$GOLD/global"

# ensure sandbox is active so installer steps do not touch user's home
make_sandbox

# 7 path-distinct colour schemes: 4 flavour reps (crust selFg) + 3 Latte white-selFg overrides
gen_colors() {
    rm -rf ./dist
    ./install.sh -q "$1" "$2" 1 color >/dev/null
    cp "./dist/Catppuccin$3.colors" "$GOLD/Catppuccin$3.colors"
}
gen_colors 1 13 MochaBlue
gen_colors 2 13 MacchiatoBlue
gen_colors 3 13 FrappeBlue
gen_colors 4 9 LatteGreen
gen_colors 4 5 LatteRed
gen_colors 4 4 LatteMauve
gen_colors 4 13 LatteBlue

# one generated splash busywidget.svg (Mocha/Blue) — a residual scan can't catch a
# wrong rgb, so freeze the bytes
make_sandbox
rm -rf ./dist
./install.sh -q 1 13 1 splash >/dev/null
cp "./dist/Catppuccin-Mocha-Blue-splash/contents/splash/images/busywidget.svg" "$GOLD/busywidget.svg"

# one global theme defaults + metadata combo (Mocha/Blue/Modern) — catches a wrong
# StoreAuroraeNo or cursor/aurorae substitution that a residual scan passes
make_sandbox
rm -rf ./dist
./install.sh -q 1 13 1 global >/dev/null
cp "./dist/Catppuccin-Mocha-Blue/contents/defaults" "$GOLD/global/defaults"
cp "./dist/Catppuccin-Mocha-Blue/metadata.json" "$GOLD/global/metadata.json"
cp "./dist/Catppuccin-Mocha-Blue/metadata.desktop" "$GOLD/global/metadata.desktop"

# this reads the .sed internals directly. if the sed pipeline gets replaced or
# refactored, this parsing breaks. known coupling point.
# canonical palette: 104 rgbs (26 tokens x 4 flavours) parsed from the .sed pallets.
# verified against catppuccin upstream by hand at release time.
: >tests/canonical-palette.txt
for f in Mocha Macchiato Frappe Latte; do
    awk -v fl="$f" -F'/' '/^s\/\$/ {tok=$2; sub(/^\$/, "", tok); print fl, tok, $3}' "Installer/Pallets/$f.sed" >>tests/canonical-palette.txt
done

rm -rf ./dist
echo "regenerated fixtures under tests/"
