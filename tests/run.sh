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

# shared by the splash and look-and-feel combo loops: checks metadata.json is
# valid, metadata.desktop has [Desktop Entry], and every asset (metadata plus
# whatever mode-specific paths are passed in) is non-empty and residual-clean.
# returns non-zero on any failure; caller sets its own fail-flag variable.
# (cma_ prefix: POSIX sh functions share the caller's scope, and both loops
# already use "base" for their own combo path.)
check_metadata_assets() {
    cma_base=$1
    cma_label=$2
    shift 2
    cma_fail=0
    for cma_asset in "$@" "$cma_base/metadata.json" "$cma_base/metadata.desktop"; do
        if [ ! -s "$cma_asset" ]; then
            bad "missing asset $cma_asset"
            cma_fail=1
        elif grep -Eq "$RESIDUAL" "$cma_asset"; then
            bad "residual in $cma_asset"
            cma_fail=1
        fi
    done
    jq empty "$cma_base/metadata.json" 2>/dev/null || {
        bad "invalid generated metadata.json: $cma_label"
        cma_fail=1
    }
    grep -q '^\[Desktop Entry\]' "$cma_base/metadata.desktop" || {
        bad "generated metadata.desktop missing [Desktop Entry]: $cma_label"
        cma_fail=1
    }
    return "$cma_fail"
}

FLAVOURS="1:Mocha 2:Macchiato 3:Frappe 4:Latte"
ACCENTS="1:Rosewater 2:Flamingo 3:Pink 4:Mauve 5:Red 6:Maroon 7:Peach 8:Yellow 9:Green 10:Teal 11:Sky 12:Sapphire 13:Blue 14:Lavender"
# bare $ is an end-anchor (matches nothing); escape it. covers sed-era token
# families plus Tera delimiter leaks from the generated/ whiskers tree.
RESIDUAL='\{\{|\}\}|\{%|%\}|\{#|\$[a-z0-9]|--[a-zA-Z]'

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

# ---- generated/ structural completeness: catches a partial regenerate ----
section "generated/ structural completeness"
n=$(find generated/color-schemes -maxdepth 1 -name '*.colors' | wc -l | tr -d ' ')
if [ "$n" -eq 56 ]; then ok "56 .colors files in generated/color-schemes"; else bad "expected 56 .colors files, found $n"; fi
n=$(find generated/splash -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
if [ "$n" -eq 56 ]; then ok "56 combo dirs in generated/splash"; else bad "expected 56 splash dirs, found $n"; fi
n=$(find generated/splash-qml -maxdepth 1 -name '*.qml' | wc -l | tr -d ' ')
if [ "$n" -eq 4 ]; then ok "4 Splash.qml files in generated/splash-qml"; else bad "expected 4 Splash.qml files, found $n"; fi
n=$(find generated/look-and-feel -mindepth 2 -maxdepth 2 -type d | wc -l | tr -d ' ')
if [ "$n" -eq 112 ]; then ok "112 combo dirs in generated/look-and-feel"; else bad "expected 112 look-and-feel dirs, found $n"; fi
want_file generated/canonical-palette.txt "generated/canonical-palette.txt present" "generated/canonical-palette.txt missing"

# lookandfeel-defaults.tera interpolates the decoration matrix variable
# ({{decoration}}) with no validation of its own; a casing typo there would
# silently render a theme= line matching no Aurorae directory on disk. also
# pin the exact [kcminputrc][Mouse] header string install.sh's --no-cursor
# section-strip matches against, so a template edit that drifts it (a stray
# space, different casing) is caught here instead of silently disabling -n.
decoration_fail=0
header_fail=0
for f in generated/look-and-feel/*/*/contents/defaults; do
    theme_line=$(grep '^theme=' "$f")
    case "$theme_line" in
        theme=__aurorae__svg__Catppuccin*-Modern | theme=__aurorae__svg__Catppuccin*-Classic) ;;
        *)
            bad "unexpected decoration suffix in $f: $theme_line"
            decoration_fail=1
            ;;
    esac
    grep -qx '\[kcminputrc\]\[Mouse\]' "$f" || {
        bad "kcminputrc header missing/altered in $f"
        header_fail=1
    }
done
[ "$decoration_fail" -eq 0 ] && ok "every generated look-and-feel defaults has an exact Modern/Classic decoration suffix"
[ "$header_fail" -eq 0 ] && ok "every generated look-and-feel defaults has the literal [kcminputrc][Mouse] header --no-cursor matches against"

# ---- StoreAuroraeNo table: catches a frontmatter-map typo whiskers --check can't see (a wrong-but-valid id renders and diffs clean either way) ----
section "StoreAuroraeNo table (8 flavour x decoration ids)"
check_store_aurorae() {
    # the store_aurorae map is duplicated by hand across the .desktop and .json
    # templates; check both copies so the two can't silently desync.
    base="generated/look-and-feel/$2/Catppuccin-$1-Blue"
    got_desktop=$(grep -o 'kns://aurorae.knsrc/api.kde-look.org/[0-9]*' "$base/metadata.desktop" | grep -o '[0-9]*$')
    got_json=$(grep -o 'kns://aurorae.knsrc/api.kde-look.org/[0-9]*' "$base/metadata.json" | grep -o '[0-9]*$')
    if [ "$got_desktop" = "$3" ] && [ "$got_json" = "$3" ]; then
        ok "StoreAuroraeNo $1/$2 = $3 (metadata.desktop + metadata.json agree)"
    else
        bad "StoreAuroraeNo $1/$2 expected $3, got desktop=$got_desktop json=$got_json"
    fi
}
check_store_aurorae Mocha Modern 2135229
check_store_aurorae Mocha Classic 2135228
check_store_aurorae Macchiato Modern 2135227
check_store_aurorae Macchiato Classic 2135226
check_store_aurorae Frappe Modern 2135225
check_store_aurorae Frappe Classic 2135224
check_store_aurorae Latte Modern 2135223
check_store_aurorae Latte Classic 2135222

# negative assert: a non-override accent on Latte keeps the crust selFg, not white
make_sandbox
rm -rf ./dist
./install.sh -q 4 9 1 color >/dev/null 2>&1
sel=$(grep -A12 '^\[Colors:Selection\]' ./dist/CatppuccinLatteGreen.colors | grep -m1 '^ForegroundNormal=' | cut -d= -f2)
if [ "$sel" = "17, 17, 27" ]; then ok "Latte/Green selFg stays crust (not white)"; else bad "Latte/Green selFg expected '17, 17, 27', got '$sel'"; fi

# --local-cursor's one runtime edit: the baked defaults ship the accent's own
# cursor set, which -c must overwrite with the local dir's basename.
make_sandbox
rm -rf ./dist
./install.sh -q -c "$SANDBOX/cursor" 1 13 1 global >/dev/null 2>&1
cursor_theme=$(grep '^cursorTheme=' ./dist/Catppuccin-Mocha-Blue/contents/defaults | cut -d= -f2)
if [ "$cursor_theme" = "$(basename "$SANDBOX/cursor")" ]; then
    ok "-c: installed defaults cursorTheme equals the local cursor dir's basename"
else
    bad "-c: defaults cursorTheme expected '$(basename "$SANDBOX/cursor")', got '$cursor_theme'"
fi
rm -rf ./dist
./install.sh -q 1 13 1 global >/dev/null 2>&1
cursor_theme=$(grep '^cursorTheme=' ./dist/Catppuccin-Mocha-Blue/contents/defaults | cut -d= -f2)
if [ "$cursor_theme" = "catppuccin-mocha-blue-cursors" ]; then
    ok "non--c: defaults cursorTheme stays the baked accent default"
else
    bad "non--c: defaults cursorTheme expected 'catppuccin-mocha-blue-cursors', got '$cursor_theme'"
fi

# --no-cursor drops the whole [kcminputrc][Mouse] section, not just the value:
# plasma-apply-lookandfeel applies every key in defaults verbatim, so a baked
# cursorTheme would still overwrite the user's current cursor even though no
# cursor was ever installed.
rm -rf ./dist
./install.sh -q --no-cursor 1 13 1 global >/dev/null 2>&1
nocursor_defaults=$(cat ./dist/Catppuccin-Mocha-Blue/contents/defaults)
if ! printf '%s' "$nocursor_defaults" | grep -q 'kcminputrc\|cursorTheme'; then
    ok "--no-cursor: [kcminputrc][Mouse] section absent from installed defaults"
else
    bad "--no-cursor: defaults still references kcminputrc/cursorTheme"
fi
rm -rf ./dist
./install.sh -q 1 13 1 global >/dev/null 2>&1
# remove the header line through the following blank line, same span install.sh
# itself drops, so this is a fair byte-for-byte comparison of "everything else"
baseline_stripped=$(sed '/^\[kcminputrc\]\[Mouse\]$/,/^$/d' ./dist/Catppuccin-Mocha-Blue/contents/defaults)
if [ "$nocursor_defaults" = "$baseline_stripped" ]; then
    ok "--no-cursor: rest of defaults is untouched apart from that section"
else
    bad "--no-cursor: defaults diverged beyond the [kcminputrc][Mouse] section"
fi

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
whiskers_fail=0
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

        # install.sh selects and copies from generated/ (Whiskers output); this
        # catches a path-construction bug landing the wrong combo's file in dist.
        whiskers_out="generated/color-schemes/Catppuccin$fn$an.colors"
        if [ ! -f "$whiskers_out" ]; then
            bad "missing generated/ counterpart: $fn/$an"
            whiskers_fail=1
        elif ! diff -q "$out" "$whiskers_out" >/dev/null 2>&1; then
            bad "dist output doesn't match generated/color-schemes/ source: $fn/$an"
            whiskers_fail=1
        fi
    done
done
[ "$combo_fail" -eq 0 ] && ok "56 colour schemes built, non-empty, residual-clean"
[ "$pal_fail" -eq 0 ] && ok "every generated rgb across 56 combos is a canonical catppuccin value"
[ "$whiskers_fail" -eq 0 ] && ok "dist output matches its generated/color-schemes/ source across 56 combos"

# splash residual (REPLACE--ACCENT / REPLACE--MANTLE) + generated metadata sanity
section "smoke + residual (56 splash combos)"
make_sandbox
splash_fail=0
splash_whiskers_fail=0
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
        check_metadata_assets "$base" "$fn/$an" \
            "$base/contents/splash/images/busywidget.svg" "$base/contents/splash/Splash.qml" ||
            splash_fail=1

        # install.sh selects and copies from generated/ (Whiskers output); this
        # catches a path-construction bug landing the wrong combo's file in dist.
        # Splash.qml is rendered per-flavour, not per-combo.
        whiskers_base="generated/splash/Catppuccin-$fn-$an-splash"
        for f in contents/splash/images/busywidget.svg metadata.desktop metadata.json; do
            if ! diff -q "$base/$f" "$whiskers_base/$f" >/dev/null 2>&1; then
                bad "dist output doesn't match generated/splash/ source: $fn/$an/$f"
                splash_whiskers_fail=1
            fi
        done
        if ! diff -q "$base/contents/splash/Splash.qml" "generated/splash-qml/Catppuccin$fn-Splash.qml" >/dev/null 2>&1; then
            bad "dist output doesn't match generated/splash-qml/ source: $fn"
            splash_whiskers_fail=1
        fi
    done
done
[ "$splash_fail" -eq 0 ] && ok "56 splash builds residual-clean + valid generated metadata"
[ "$splash_whiskers_fail" -eq 0 ] && ok "dist output matches its generated/splash + generated/splash-qml source across 56 combos"

# ---- smoke + residual over all 112 look-and-feel combos ----
section "smoke + residual (112 look-and-feel combos)"
make_sandbox
global_fail=0
global_whiskers_fail=0
DECORATIONS="1:Modern 2:Classic"
for fe in $FLAVOURS; do
    fn=${fe#*:}
    fnum=${fe%%:*}
    for ae in $ACCENTS; do
        an=${ae#*:}
        anum=${ae%%:*}
        for de in $DECORATIONS; do
            dn=${de#*:}
            dnum=${de%%:*}
            rm -rf ./dist
            if ! ./install.sh -q "$fnum" "$anum" "$dnum" global >/dev/null 2>&1; then
                bad "global build failed: $fn/$an/$dn"
                global_fail=1
                continue
            fi
            base="./dist/Catppuccin-$fn-$an"
            check_metadata_assets "$base" "$fn/$an/$dn" "$base/contents/defaults" ||
                global_fail=1

            # install.sh selects and copies from generated/ (Whiskers output);
            # this catches a path-construction bug landing the wrong combo's
            # file in dist. (contents/defaults only differs from this source
            # under --local-cursor, not exercised by this non--c loop.)
            whiskers_base="generated/look-and-feel/$dn/Catppuccin-$fn-$an"
            for f in contents/defaults metadata.desktop metadata.json; do
                if ! diff -q "$base/$f" "$whiskers_base/$f" >/dev/null 2>&1; then
                    bad "dist output doesn't match generated/look-and-feel/ source: $fn/$an/$dn/$f"
                    global_whiskers_fail=1
                fi
            done
        done
    done
done
[ "$global_fail" -eq 0 ] && ok "112 look-and-feel builds residual-clean + valid generated metadata"
[ "$global_whiskers_fail" -eq 0 ] && ok "dist output matches its generated/look-and-feel/ source across 112 combos"

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
expect_fail "cursor mode rejects -n" "does not support --no-cursor" -n 1 13 1 cursor
expect_fail "-c and -n are mutually exclusive" "mutually exclusive" -c "$SANDBOX/cursor" -n 1 13 1 color

# ---- sandboxed e2e (item 23) ----
section "e2e (sandboxed full install)"
make_sandbox
rm -rf ./dist
if ./install.sh -q -c "$SANDBOX/cursor" 4 13 2 auto >/dev/null 2>&1; then
    want_file "$SANDBOX/data/color-schemes/CatppuccinLatteBlue.colors" "auto -c: colour scheme landed" "auto -c: colour scheme missing"
    want_dir "$SANDBOX/data/aurorae/themes/CatppuccinLatte-Classic" "auto -c: aurorae theme landed" "auto -c: aurorae missing"
    want_file "$SANDBOX/data/kpackagetool6.calls" "auto -c: kpackagetool6 stub was called" "auto -c: kpackagetool6 stub was not called"
    want_dir "$SANDBOX/data/icons/cursor" "auto -c: offline cursor landed under basename" "auto -c: cursor missing"
else
    bad "auto -c: installer exited non-zero"
fi

# --no-cursor: full auto install, no cursor ever downloaded or touched
make_sandbox
rm -rf ./dist
if ./install.sh -q --no-cursor 1 13 2 auto >/dev/null 2>&1; then
    want_file "$SANDBOX/data/color-schemes/CatppuccinMochaBlue.colors" "auto --no-cursor: colour scheme landed" "auto --no-cursor: colour scheme missing"
    want_dir "$SANDBOX/data/aurorae/themes/CatppuccinMocha-Classic" "auto --no-cursor: aurorae theme landed" "auto --no-cursor: aurorae missing"
    want_file "$SANDBOX/data/kpackagetool6.calls" "auto --no-cursor: kpackagetool6 stub was called" "auto --no-cursor: kpackagetool6 stub was not called"
    if [ -z "$(ls -A "$SANDBOX/data/icons" 2>/dev/null)" ]; then
        ok "auto --no-cursor: no cursor theme installed"
    else
        bad "auto --no-cursor: unexpected content in icons dir: $(ls "$SANDBOX/data/icons")"
    fi
else
    bad "auto --no-cursor: installer exited non-zero"
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
    want_file "$SANDBOX/data/kpackagetool6.calls" "README: kpackagetool6 stub was called" "README: kpackagetool6 stub was not called"
    want_dir "$SANDBOX/data/icons/catppuccin-mocha-blue-cursors" "README invocation: cursor landed" "README invocation: cursor missing"
else
    bad "README invocation: installer exited non-zero"
fi

section "result"
printf 'PASS=%d FAIL=%d\n' "$PASS" "$FAIL"
[ "$FAIL" -eq 0 ]
