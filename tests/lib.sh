#!/bin/sh
# shared helpers for the POSIX test suite. sourced, not run directly.
# everything that drives the installer does so inside a throwaway XDG sandbox
# with stubbed plasma tools, so the real desktop is never touched.

REPO_ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$REPO_ROOT" || exit 1
ORIG_PATH=$PATH
TEST_TMP=$(mktemp -d)
trap 'rm -rf "$TEST_TMP" "$REPO_ROOT/dist"' EXIT INT TERM

# make_sandbox: fresh XDG dirs + plasma stubs, exported into the environment.
# sets SANDBOX to the new dir.
make_sandbox() {
    SANDBOX=$(mktemp -d "$TEST_TMP/sb.XXXXXX")
    mkdir -p "$SANDBOX/data" "$SANDBOX/config" "$SANDBOX/cache" "$SANDBOX/bin" "$SANDBOX/cursor"

    # kpackagetool6 no-op stub that records it was called and creates the destination
    # directory structure so that subsequent cp commands in the installer do not fail.
    cat >"$SANDBOX/bin/kpackagetool6" <<'STUB'
#!/bin/sh
dest="$XDG_DATA_HOME/plasma/look-and-feel"
tarball="" prev=""
for a in "$@"; do
    case "$prev" in
    -i | -u) tarball=$a ;;
    *) ;;
    esac
    prev=$a
done
if [ -n "$tarball" ]; then
    theme=$(basename "$tarball" .tar.gz)
    mkdir -p "$dest/$theme/contents/previews"
fi
echo "kpackagetool6 called with: $*" >> "$XDG_DATA_HOME/kpackagetool6.calls"
exit 0
STUB
    printf '#!/bin/sh\nexit 0\n' >"$SANDBOX/bin/kwriteconfig6"
    printf '#!/bin/sh\nexit 0\n' >"$SANDBOX/bin/plasma-apply-lookandfeel"
    chmod +x "$SANDBOX/bin/kpackagetool6" "$SANDBOX/bin/kwriteconfig6" "$SANDBOX/bin/plasma-apply-lookandfeel"

    # minimal valid local cursor theme for the offline -c path
    printf '[Icon Theme]\nName=catppuccin-test\n' >"$SANDBOX/cursor/index.theme"

    export XDG_DATA_HOME="$SANDBOX/data"
    export XDG_CONFIG_HOME="$SANDBOX/config"
    export XDG_CACHE_HOME="$SANDBOX/cache"
    export PATH="$SANDBOX/bin:$ORIG_PATH"
}

# stub_cursor_download: add wget/unzip stubs so a network-free `auto` run can
# exercise the cursor download path deterministically.
stub_cursor_download() {
    cat >"$SANDBOX/bin/wget" <<'STUB'
#!/bin/sh
dir="." url=""
prev=""
for a in "$@"; do
    case "$prev" in
    -P) dir=$a ;;
    *) ;;
    esac
    url=$a
    prev=$a
done
zip=$dir/$(basename "$url")
printf 'stub\n' >"$zip"
exit 0
STUB
    cat >"$SANDBOX/bin/unzip" <<'STUB'
#!/bin/sh
target=""
for a in "$@"; do target=$a; done
name=$(basename "$target" .zip)
mkdir -p "$name"
printf '[Icon Theme]\nName=%s\n' "$name" >"$name/index.theme"
exit 0
STUB
    chmod +x "$SANDBOX/bin/wget" "$SANDBOX/bin/unzip"
}
