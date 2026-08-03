# Pinned Whiskers release (https://github.com/catppuccin/whiskers) used to render templates/.
# PATH whiskers is unsupported for regeneration: a newer version can render subtly different
# bytes (hex casing, newline, spacing) and produce a spurious diff. Always go through _fetch-whiskers.
whiskers_version := "2.9.0"

default:
    @just --list

# Render every template in templates/ with the pinned Whiskers binary into generated/.
build: _fetch-whiskers
    #!/usr/bin/env sh
    set -eu
    if [ -d templates ] && [ -n "$(find templates -maxdepth 1 -name '*.tera' -print -quit)" ]; then
        for f in templates/*.tera; do
            .bin/whiskers "$f"
        done
    else
        echo "No templates/*.tera found yet; nothing to build." >&2
    fi

# Check every template's committed output in generated/ against a fresh render (CI drift guard).
check: _fetch-whiskers
    #!/usr/bin/env sh
    set -eu
    if [ -d templates ] && [ -n "$(find templates -maxdepth 1 -name '*.tera' -print -quit)" ]; then
        for f in templates/*.tera; do
            # single-output templates (no `matrix:` key, e.g. canonical-palette.tera)
            # need an explicit example path; multi-output templates reject one.
            if grep -q '^[[:space:]]*matrix:' "$f"; then
                .bin/whiskers "$f" --check
            else
                example=$(sed -n 's/^[[:space:]]*filename:[[:space:]]*"\(.*\)"[[:space:]]*$/\1/p' "$f" | head -n1)
                .bin/whiskers "$f" --check "$example"
            fi
        done
    else
        echo "No templates/*.tera found yet; nothing to check." >&2
    fi

# Regenerate generated/ ahead of a release/version bump. Review the diff before committing.
release-regen: build
    @echo "Regenerated generated/ from templates/. Review the diff and update tests/goldens/ as needed."

# Fetch and checksum-verify the pinned Whiskers binary into .bin/ (gitignored). Skips if already present and verified.
_fetch-whiskers:
    #!/usr/bin/env sh
    set -eu
    VERSION="{{ whiskers_version }}"
    OS=$(uname -s)
    ARCH=$(uname -m)
    case "$OS-$ARCH" in
        Linux-x86_64)
            ASSET="whiskers-x86_64-unknown-linux-gnu"
            SHA256="05a36866bd920af3b058856cf2b92fdd220da4c4ffbdf8a438b5efd1d14e11c7"
            ;;
        Darwin-arm64)
            ASSET="whiskers-aarch64-apple-darwin"
            SHA256="77748ac135b3169b80d384fdaa12559f2fb926c87d392325b247b8396506b4cb"
            ;;
        MINGW*-x86_64|MSYS*-x86_64|CYGWIN*-x86_64)
            ASSET="whiskers-x86_64-pc-windows-msvc.exe"
            SHA256="2f804ce4ede168fc40010f7562b0e81cb8ba94ed51f3583edff99bb5603589ec"
            ;;
        *)
            echo "Error: no pinned Whiskers $VERSION prebuilt binary for $OS-$ARCH." >&2
            echo "Install Rust and run: cargo install --git https://github.com/catppuccin/whiskers --tag v$VERSION --locked" >&2
            exit 1
            ;;
    esac

    BIN=".bin/whiskers"
    mkdir -p .bin
    if [ -f "$BIN" ] && [ "$(sha256sum "$BIN" | cut -d' ' -f1)" = "$SHA256" ]; then
        exit 0
    fi

    URL="https://github.com/catppuccin/whiskers/releases/download/v$VERSION/$ASSET"
    TMP="$(mktemp)"
    curl -sL -o "$TMP" "$URL"
    ACTUAL="$(sha256sum "$TMP" | cut -d' ' -f1)"
    if [ "$ACTUAL" != "$SHA256" ]; then
        echo "Error: checksum mismatch for $ASSET" >&2
        echo "  expected: $SHA256" >&2
        echo "  actual:   $ACTUAL" >&2
        rm -f "$TMP"
        exit 1
    fi
    mv "$TMP" "$BIN"
    chmod +x "$BIN"
    echo "Fetched and verified whiskers $VERSION -> $BIN"
