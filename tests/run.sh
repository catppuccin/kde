#!/bin/sh
# POSIX test suite for the installer. drives install.sh through its entry point in a
# throwaway XDG sandbox (real desktop untouched) and checks outputs and contracts so
# the suite outlives the sed colour pipeline. no bats: plain shell + git diff.
set -u
libdir=$(dirname "$0")
# shellcheck source=tests/lib.sh
. "$libdir/lib.sh"

PASS=0
FAIL=0
ok() {
    PASS=$((PASS + 1))
    printf '  ok   %s\n' "$1"
}
bad() {
    FAIL=$((FAIL + 1))
    printf '  FAIL %s\n' "$1" >&2
}
section() { printf '\n== %s ==\n' "$1"; }
want_file() { if [ -f "$1" ]; then ok "$2"; else bad "$3"; fi; }
want_dir() { if [ -d "$1" ]; then ok "$2"; else bad "$3"; fi; }

FLAVOURS="1:Mocha 2:Macchiato 3:Frappe 4:Latte"
ACCENTS="1:Rosewater 2:Flamingo 3:Pink 4:Mauve 5:Red 6:Maroon 7:Peach 8:Yellow 9:Green 10:Teal 11:Sky 12:Sapphire 13:Blue 14:Lavender"
# bare $ is an end-anchor (matches nothing); escape it. covers both token families.
RESIDUAL='\$[a-z0-9]|--[a-zA-Z]'

# ---- goldens + palette snapshot (items 18, 20) ----
section "goldens (regenerate via installer, then diff)"
if ! sh tests/regen-goldens.sh >/dev/null; then
    bad "regen-goldens.sh failed (installer broke before producing fixtures)"
elif git diff --quiet -- tests/goldens tests/canonical-palette.txt; then
    ok "fixtures match committed goldens"
else
    bad "fixtures drifted (run tests/regen-goldens.sh, review, commit)"
    git --no-pager diff --stat -- tests/goldens tests/canonical-palette.txt >&2
fi

# negative assert: a non-override accent on Latte keeps the crust selFg, not white
rm -rf ./dist
./install.sh -q 4 9 1 color >/dev/null 2>&1
sel=$(grep -A12 '^\[Colors:Selection\]' ./dist/CatppuccinLatteGreen.colors | grep -m1 '^ForegroundNormal=' | cut -d= -f2)
if [ "$sel" = "17, 17, 27" ]; then ok "Latte/Green selFg stays crust (not white)"; else bad "Latte/Green selFg expected '17, 17, 27', got '$sel'"; fi

# ---- smoke + residual + palette over all 56 colour combos (items 18, 21) ----
section "smoke + residual + palette (56 colour combos)"
# allowed rgbs per flavour = its canonical palette + the two selFg values
for fe in $FLAVOURS; do
    fnum=${fe%%:*}
    fn=${fe#*:}
    af="$TEST_TMP/allowed.$fnum"
    awk -v fl="$fn" '$1 == fl {print $3, $4, $5}' tests/canonical-palette.txt >"$af"
    printf '17, 17, 27\n255, 255, 255\n' >>"$af"
done
combo_fail=0
pal_fail=0
for fe in $FLAVOURS; do
    fn=${fe#*:}
    fnum=${fe%%:*}
    af="$TEST_TMP/allowed.$fnum"
    for ae in $ACCENTS; do
        an=${ae#*:}
        anum=${ae%%:*}
        rm -rf ./dist
        if ! ./install.sh -q "$fnum" "$anum" 1 color >/dev/null 2>&1; then
            bad "colour build failed: $fn/$an"
            combo_fail=1
            continue
        fi
        out="./dist/Catppuccin$fn$an.colors"
        if [ ! -s "$out" ]; then
            bad "empty colours: $fn/$an"
            combo_fail=1
            continue
        fi
        if grep -Eq "$RESIDUAL" "$out"; then
            bad "residual token in $fn/$an colours"
            grep -nE "$RESIDUAL" "$out" | head >&2
            combo_fail=1
        fi
        noncanon=$(grep -oE '[0-9]+, [0-9]+, [0-9]+' "$out" | sort -u | grep -Fxv -f "$af" || true)
        if [ -n "$noncanon" ]; then
            bad "non-canonical rgb in $fn/$an: $(printf '%s' "$noncanon" | tr '\n' ' ')"
            pal_fail=1
        fi
    done
done
[ "$combo_fail" -eq 0 ] && ok "56 colour schemes built, non-empty, residual-clean"
[ "$pal_fail" -eq 0 ] && ok "every generated rgb across 56 combos is a canonical catppuccin value"

# splash residual (REPLACE--ACCENT / REPLACE--MANTLE) + generated metadata sanity
section "smoke + residual (56 splash combos)"
make_sandbox
splash_fail=0
for fe in $FLAVOURS; do
    fn=${fe#*:}
    fnum=${fe%%:*}
    for ae in $ACCENTS; do
        an=${ae#*:}
        anum=${ae%%:*}
        rm -rf ./dist
        if ! ./install.sh -q "$fnum" "$anum" 1 splash >/dev/null 2>&1; then
            bad "splash build failed: $fn/$an"
            splash_fail=1
            continue
        fi
        base="./dist/Catppuccin-$fn-$an-splash"
        for asset in "$base/contents/splash/images/busywidget.svg" "$base/contents/splash/Splash.qml"; do
            if [ ! -s "$asset" ]; then
                bad "missing splash asset $asset"
                splash_fail=1
            elif grep -Eq "$RESIDUAL" "$asset"; then
                bad "residual in $asset"
                splash_fail=1
            fi
        done
        jq empty "$base/metadata.json" 2>/dev/null || {
            bad "invalid generated metadata.json: $fn/$an"
            splash_fail=1
        }
        grep -q '^\[Desktop Entry\]' "$base/metadata.desktop" || {
            bad "generated metadata.desktop missing [Desktop Entry]: $fn/$an"
            splash_fail=1
        }
    done
done
[ "$splash_fail" -eq 0 ] && ok "56 splash builds residual-clean + valid generated metadata"

# ---- arg parsing (item 22) ----
section "arg parsing"
make_sandbox
expect_fail() {
    desc=$1
    want=$2
    shift 2
    out=$(./install.sh "$@" 2>&1 </dev/null)
    rc=$?
    if [ "$rc" -ne 0 ] && printf '%s' "$out" | grep -qF "$want"; then
        ok "$desc"
    else
        bad "$desc (rc=$rc): $out"
    fi
}
expect_fail "invalid flavour exits with arg error" "Not a valid flavour" -q 9 13 1 color
expect_fail "invalid accent exits with arg error" "Not a valid accent" -q 1 99 1 color
expect_fail "invalid windec exits with arg error" "Not a valid Window decoration" -q 1 13 9 color
expect_fail "missing flavour under -q" "Missing flavour" -q
expect_fail "missing accent under -q" "Missing accent" -q 1
expect_fail "-c without a path" "Missing local cursor path" -c
expect_fail "-c with a bad path" "must be a cursor theme directory" -c /no/such/dir 1 13 1 color
expect_fail "cursor mode rejects -c" "does not support --local-cursor" -c "$SANDBOX/cursor" 1 13 1 cursor

# ---- sandboxed e2e (item 23) ----
section "e2e (sandboxed full install)"
make_sandbox
rm -rf ./dist
if ./install.sh -q -c "$SANDBOX/cursor" 4 13 2 auto >/dev/null 2>&1; then
    want_file "$SANDBOX/data/color-schemes/CatppuccinLatteBlue.colors" "auto -c: colour scheme landed" "auto -c: colour scheme missing"
    want_dir "$SANDBOX/data/aurorae/themes/CatppuccinLatte-Classic" "auto -c: aurorae theme landed" "auto -c: aurorae missing"
    want_dir "$SANDBOX/data/plasma/look-and-feel/Catppuccin-Latte-Blue" "auto -c: look-and-feel landed" "auto -c: look-and-feel missing"
    want_dir "$SANDBOX/data/icons/cursor" "auto -c: offline cursor landed under basename" "auto -c: cursor missing"
else
    bad "auto -c: installer exited non-zero"
fi

# -c where the source already is the install target: the copy must skip, not wipe it
make_sandbox
mkdir -p "$SANDBOX/data/icons/mytheme"
printf '[Icon Theme]\nName=mytheme\n' >"$SANDBOX/data/icons/mytheme/index.theme"
rm -rf ./dist
if ./install.sh -q -c "$SANDBOX/data/icons/mytheme" 1 13 1 auto >/dev/null 2>&1; then
    want_file "$SANDBOX/data/icons/mytheme/index.theme" "auto -c: source==target cursor left intact" "auto -c: source==target cursor was clobbered"
else
    bad "auto -c source==target: installer exited non-zero"
fi

# the exact README invocation, network-free via wget/unzip stubs, so doc/code drift fails ci
make_sandbox
stub_cursor_download
rm -rf ./dist
if ./install.sh 1 13 2 auto >/dev/null 2>&1 </dev/null; then
    want_file "$SANDBOX/data/color-schemes/CatppuccinMochaBlue.colors" "README './install.sh 1 13 2 auto' completes + installs" "README invocation: colour scheme missing"
    want_dir "$SANDBOX/data/icons/catppuccin-mocha-blue-cursors" "README invocation: cursor landed" "README invocation: cursor missing"
else
    bad "README invocation: installer exited non-zero"
fi

section "result"
printf 'PASS=%d FAIL=%d\n' "$PASS" "$FAIL"
[ "$FAIL" -eq 0 ]
