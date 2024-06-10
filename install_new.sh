#!/usr/bin/env sh
set -eax

check_command_exists() {
  command_name="${*}"

  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Error: Dependency '$command_name' is not met."
    echo "Exiting.."
    exit 1
  fi
}

check_command_exists "curl"
check_command_exists "tar"

URL=""
generate_release_url() {
  flavor="$1"
  accent="$2"

  base="https://github.com/catppuccin/kde/releases/download"
  version="v0.2.6"

  URL="$base/$version/$flavor-$accent.tar.gz"
}

FLAVOUR="$1"
ACCENT="$2"
STYLE="$3"

if [ -z "$1" ]; then
    cat <<EOF

Choose flavor out of -
    1. Mocha
    2. Macchiato
    3. Frappé
    4. Latte
    (Type the number corresponding to said palette)
EOF
    read -r FLAVOUR
fi

case "$FLAVOUR" in
    1) FLAVOURNAME="mocha" ;;
    2) FLAVOURNAME="macchiato" ;;
    3) FLAVOURNAME="frappe" ;;
    4) FLAVOURNAME="latte" ;;
    *)
        echo "Not a valid flavour name: $FLAVOUR"
        exit 1
        ;;
esac
echo

if [ -z "$2" ]; then
    cat <<EOF
Choose an accent -
    1. Rosewater
    2. Flamingo
    3. Pink
    4. Mauve
    5. Red
    6. Maroon
    7. Peach
    8. Yellow
    9. Green
    10. Teal
    11. Sky
    12. Sapphire
    13. Blue
    14. Lavender
EOF
    read -r ACCENT
fi

case "$ACCENT" in
    1)
        ACCENTNAME="rosewater"
        ;;
    2)
        ACCENTNAME="flamingo"
        ;;
    3)
        ACCENTNAME="pink"
        ;;
    4)
        ACCENTNAME="mauve"
        ;;
    5)
        ACCENTNAME="red"
        ;;
    6)
        ACCENTNAME="maroon"
        ;;
    7)
        ACCENTNAME="peach"
        ;;
    8)
        ACCENTNAME="yellow"
        ;;
    9)
        ACCENTNAME="green"
        ;;
    10)
        ACCENTNAME="teal"
        ;;
    11)
        ACCENTNAME="sky"
        ;;
    12)
        ACCENTNAME="sapphire"
        ;;
    13)
        ACCENTNAME="blue"
        ;;
    14)
        ACCENTNAME="lavender"
        ;;
    *)
        echo "Not a valid accent: $ACCENT"
        exit 1
        ;;
esac
echo

if [ -z "$2" ]; then
    cat <<EOF
Choose a style -
    1. Modern
    2. Classic
EOF
    read -r ACCENT
fi

case "$STYLE" in
    1)
        STYLENAME="modern"
        ;;
    2)
        STYLENAME="classic"
        ;;
    *)
        echo "Not a valid style: $STYLE"
        exit 1
        ;;
esac
echo

COLORDIR="${XDG_DATA_HOME:-$HOME/.local/share}/color-schemes"
AURORAEDIR="${XDG_DATA_HOME:-$HOME/.local/share}/aurorae/themes"
LOOKANDFEELDIR="${XDG_DATA_HOME:-$HOME/.local/share}/plasma/look-and-feel"
CURSORDIR="${XDG_DATA_HOME:-$HOME/.local/share}/icons"
mkdir -p "$COLORDIR" "$AURORAEDIR" "$LOOKANDFEELDIR" "$CURSORDIR"

generate_release_url "$FLAVOURNAME" "$ACCENTNAME"
cat <<EOF 
Build info:
  flavor:     $FLAVOURNAME
  accent:     $ACCENTNAME
  style:      $STYLENAME
  remote url: $URL
EOF
echo

DISTDIR="$PWD/dist"

echo -n "Changing into temporary dir... "
cd $(mktemp -d)
echo "Done"

echo -n "Fetching zip... "
# curl "$URL" -o ./theme.zip
cp "$DISTDIR/catppuccin-mocha-blue.tar.gz" ./theme.tar.gz
echo "Done"

echo -n "Unzipping... "
tar -xzf theme.tar.gz
echo "Done"

GLOBALTHEMENAME="catppuccin-$FLAVOURNAME-$ACCENTNAME"
SPLASHSCREENNAME="catppuccin-$FLAVOURNAME-$ACCENTNAME-splash"
SRCROOT="$GLOBALTHEMENAME"

# ls "$SRCROOT"
# ls
# echo "$SRCROOT"
# echo "$PWD"

echo -n "Setting up theme for installation... "
cp "$SRCROOT/contents/defaults.$STYLENAME" "$SRCROOT/contents/defaults"
echo "Done"

echo "Installing KDE theme..."
kpackagetool5 -i "theme.tar.gz"
echo "Done"

echo -n "Moving files to home dir..."
cp -r "$SRCROOT/Splash/contents/splash" "$LOOKANDFEELDIR/$GLOBALTHEMENAME/contents"
cp -r "$SRCROOT/Splash/contents/previews" "$LOOKANDFEELDIR/$GLOBALTHEMENAME/contents/previews"
cp -r "$SRCROOT/catppuccin-$FLAVOURNAME-$STYLENAME" "$AURORAEDIR"

cp -r "$SRCROOT/metadata.desktop" "$LOOKANDFEELDIR/$GLOBALTHEMENAME"
cp -r "$SRCROOT/metadata.json" "$LOOKANDFEELDIR/$GLOBALTHEMENAME"
cp -r "$SRCROOT/theme.colors" "$COLORDIR/$GLOBALTHEMENAME.colors"

rm -r "$LOOKANDFEELDIR/$GLOBALTHEMENAME/catppuccin-$FLAVOURNAME-classic"
rm -r "$LOOKANDFEELDIR/$GLOBALTHEMENAME/catppuccin-$FLAVOURNAME-modern"
rm -r "$LOOKANDFEELDIR/$GLOBALTHEMENAME/Splash"
rm -r "$LOOKANDFEELDIR/$GLOBALTHEMENAME/theme.colors"
echo "Done"

echo
echo "Theme installation complete"