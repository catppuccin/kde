#!/bin/sh

# Syntax [-q|--quiet] [-c|--local-cursor <path>] <Flavour = 1-4 > <Accent = 1-14> <WindowDec = 1/2> <Debug = aurorae/global/color/splash/cursor>

set -eu

QUIET=0

LOCAL_CURSOR=0
LOCAL_CURSOR_PATH=""
LOCAL_CURSOR_NAME=""

while [ "$#" -gt 0 ]; do
    case "$1" in
        -q | --quiet)
            QUIET=1
            shift
            ;;
        -c | --local-cursor)
            shift
            if [ -z "${1:-}" ]; then
                echo "Error: Missing local cursor path." >&2
                exit 1
            fi
            LOCAL_CURSOR=1
            LOCAL_CURSOR_PATH=$1
            LOCAL_CURSOR_NAME=$(basename "$LOCAL_CURSOR_PATH")
            shift
            ;;
        *)
            break
            ;;
    esac
done

# Fast install
FLAVOUR="${1:-}"
ACCENT="${2:-}"
WINDECSTYLE="${3:-}"
DEBUGMODE="${4:-}"

log() {
    if [ "$QUIET" -ne 1 ]; then
        echo "$@"
    fi
}

missing_arg() {
    echo "Error: Missing $1." >&2
    exit 1
}

invalid_arg() {
    echo "Error: $1" >&2
    exit 1
}

check_command_exists() {
    command_name="$1"

    if ! command -v "$command_name" >/dev/null 2>&1; then
        echo "Error: Dependency '$command_name' is not met." >&2
        echo "Exiting.." >&2
        exit 1
    fi
}

# clear blanks the screen between prompts but errors under set -e on a dumb
# terminal and wipes diagnostics in ci, so only run it on a real tty.
clear_screen() {
    if [ -t 1 ]; then
        clear || true
    fi
}

if [ "$LOCAL_CURSOR" -eq 1 ] && [ "$DEBUGMODE" = "cursor" ]; then
    invalid_arg "Debug mode 'cursor' does not support --local-cursor."
fi

COLORDIR="${XDG_DATA_HOME:-$HOME/.local/share}/color-schemes"
AURORAEDIR="${XDG_DATA_HOME:-$HOME/.local/share}/aurorae/themes"
LOOKANDFEELDIR="${XDG_DATA_HOME:-$HOME/.local/share}/plasma/look-and-feel"
CURSORDIR="${XDG_DATA_HOME:-$HOME/.local/share}/icons"

log "Creating theme directories.."
mkdir -p "$COLORDIR" "$AURORAEDIR" "$LOOKANDFEELDIR" "$CURSORDIR"
mkdir -p ./dist

if [ "$DEBUGMODE" != "auto" ] && [ "$QUIET" -ne 1 ]; then
    clear_screen
fi

if [ -z "$FLAVOUR" ]; then
    if [ "$QUIET" -eq 1 ]; then
        missing_arg "flavour"
    fi
    cat <<EOF

Choose flavor out of -
    1. Mocha
    2. Macchiato
    3. Frappé
    4. Latte
    (Type the number corresponding to said palette)
EOF
    read -r FLAVOUR || true
    clear_screen
fi

case "$FLAVOUR" in
    1) FLAVOURNAME="Mocha" ;;
    2) FLAVOURNAME="Macchiato" ;;
    3) FLAVOURNAME="Frappe" ;;
    4) FLAVOURNAME="Latte" ;;
    *)
        echo "Not a valid flavour name: $FLAVOUR" >&2
        exit 1
        ;;
esac
log "$FLAVOURNAME($FLAVOUR) palette was selected."
log ""

if [ -z "$ACCENT" ]; then
    if [ "$QUIET" -eq 1 ]; then
        missing_arg "accent"
    fi
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
    read -r ACCENT || true
    clear_screen
fi

# Sets accent based on the palette selected (Best to fold this in your respective editor)
case "$ACCENT" in
    1)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="245, 224, 220" ;;
            2) ACCENTCOLOR="244, 219, 214" ;;
            3) ACCENTCOLOR="242, 213, 207" ;;
            4) ACCENTCOLOR="220, 138, 120" ;;
            *) ;;
        esac
        ACCENTNAME="Rosewater"
        ;;
    2)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="242, 205, 205" ;;
            2) ACCENTCOLOR="240, 198, 198" ;;
            3) ACCENTCOLOR="238, 190, 190" ;;
            4) ACCENTCOLOR="221, 120, 120" ;;
            *) ;;
        esac
        ACCENTNAME="Flamingo"
        ;;
    3)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="245, 194, 231" ;;
            2) ACCENTCOLOR="245, 189, 230" ;;
            3) ACCENTCOLOR="244, 184, 228" ;;
            4) ACCENTCOLOR="234, 118, 203" ;;
            *) ;;
        esac
        ACCENTNAME="Pink"
        ;;
    4)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="203, 166, 247" ;;
            2) ACCENTCOLOR="198, 160, 246" ;;
            3) ACCENTCOLOR="202, 158, 230" ;;
            4) ACCENTCOLOR="136, 57, 239" ;;
            *) ;;
        esac
        ACCENTNAME="Mauve"
        ;;
    5)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="243, 139, 168" ;;
            2) ACCENTCOLOR="237, 135, 150" ;;
            3) ACCENTCOLOR="231, 130, 132" ;;
            4) ACCENTCOLOR="210, 15, 57" ;;
            *) ;;
        esac
        ACCENTNAME="Red"
        ;;
    6)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="235, 160, 172" ;;
            2) ACCENTCOLOR="238, 153, 160" ;;
            3) ACCENTCOLOR="234, 153, 156" ;;
            4) ACCENTCOLOR="230, 69, 83" ;;
            *) ;;
        esac
        ACCENTNAME="Maroon"
        ;;
    7)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="250, 179, 135" ;;
            2) ACCENTCOLOR="245, 169, 127" ;;
            3) ACCENTCOLOR="239, 159, 118" ;;
            4) ACCENTCOLOR="254, 100, 11" ;;
            *) ;;
        esac
        ACCENTNAME="Peach"
        ;;
    8)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="249, 226, 175" ;;
            2) ACCENTCOLOR="238, 212, 159" ;;
            3) ACCENTCOLOR="229, 200, 144" ;;
            4) ACCENTCOLOR="223, 142, 29" ;;
            *) ;;
        esac
        ACCENTNAME="Yellow"
        ;;
    9)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="166, 227, 161" ;;
            2) ACCENTCOLOR="166, 218, 149" ;;
            3) ACCENTCOLOR="166, 209, 137" ;;
            4) ACCENTCOLOR="64, 160, 43" ;;
            *) ;;
        esac
        ACCENTNAME="Green"
        ;;
    10)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="148, 226, 213" ;;
            2) ACCENTCOLOR="139, 213, 202" ;;
            3) ACCENTCOLOR="129, 200, 190" ;;
            4) ACCENTCOLOR="23, 146, 153" ;;
            *) ;;
        esac
        ACCENTNAME="Teal"
        ;;
    11)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="137, 220, 235" ;;
            2) ACCENTCOLOR="145, 215, 227" ;;
            3) ACCENTCOLOR="153, 209, 219" ;;
            4) ACCENTCOLOR="4, 165, 229" ;;
            *) ;;
        esac
        ACCENTNAME="Sky"
        ;;
    12)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="116, 199, 236" ;;
            2) ACCENTCOLOR="125, 196, 228" ;;
            3) ACCENTCOLOR="133, 193, 220" ;;
            4) ACCENTCOLOR="32, 159, 181" ;;
            *) ;;
        esac
        ACCENTNAME="Sapphire"
        ;;
    13)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="137, 180, 250" ;;
            2) ACCENTCOLOR="138, 173, 244" ;;
            3) ACCENTCOLOR="140, 170, 238" ;;
            4) ACCENTCOLOR="30, 102, 245" ;;
            *) ;;
        esac
        ACCENTNAME="Blue"
        ;;
    14)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="180, 190, 254" ;;
            2) ACCENTCOLOR="183, 189, 248" ;;
            3) ACCENTCOLOR="186, 187, 241" ;;
            4) ACCENTCOLOR="114, 135, 253" ;;
            *) ;;
        esac
        ACCENTNAME="Lavender"
        ;;
    *)
        echo "Not a valid accent: $ACCENT" >&2
        exit 1
        ;;
esac
log "$ACCENTNAME($ACCENT) accent color was selected."

# v2 cursors install to lowercase dirs and KDE keys the cursor theme off the dir name
LCFLAVOUR=$(printf '%s' "$FLAVOURNAME" | tr '[:upper:]' '[:lower:]')
LCACCENT=$(printf '%s' "$ACCENTNAME" | tr '[:upper:]' '[:lower:]')
CURSORVERSION="v2.0.0"
CURSORACCENT="catppuccin-$LCFLAVOUR-$LCACCENT-cursors"
CURSORDARK="catppuccin-$LCFLAVOUR-dark-cursors"
CURSORTHEME=$CURSORACCENT

if [ "$LOCAL_CURSOR" -eq 1 ]; then
    if [ ! -d "$LOCAL_CURSOR_PATH" ]; then
        invalid_arg "Local cursor path must be a cursor theme directory: $LOCAL_CURSOR_PATH"
    fi
    if [ ! -f "$LOCAL_CURSOR_PATH/index.theme" ] && [ ! -f "$LOCAL_CURSOR_PATH/cursor.theme" ]; then
        invalid_arg "Local cursor directory must contain index.theme or cursor.theme: $LOCAL_CURSOR_PATH"
    fi
    CURSORTHEME=$LOCAL_CURSOR_NAME
fi

GLOBALTHEMENAME="Catppuccin-$FLAVOURNAME-$ACCENTNAME"
SPLASHSCREENNAME="Catppuccin-$FLAVOURNAME-$ACCENTNAME-splash"

if [ -z "$WINDECSTYLE" ]; then
    if [ "$QUIET" -eq 1 ]; then
        missing_arg "window decoration"
    fi
    cat <<EOF

Choose window decoration style -
    1. Modern (Mixed)
    2. Classic (MacOS like)
EOF
    read -r WINDECSTYLE || true
    clear_screen
fi

WINDECSTYLENAME=""
case "$WINDECSTYLE" in
    1)
        WINDECSTYLENAME=Modern
        WINDECSTYLECODE=__aurorae__svg__Catppuccin"$FLAVOURNAME"-Modern

        case "$FLAVOUR" in
            1) StoreAuroraeNo="2135229" ;;
            2) StoreAuroraeNo="2135227" ;;
            3) StoreAuroraeNo="2135225" ;;
            4) StoreAuroraeNo="2135223" ;;
            *) ;;
        esac

        if [ "$QUIET" -ne 1 ]; then
            cat <<EOF

Modern($WINDECSTYLE) decorations were selected.
These decorations have a few rules that may cause issues.
 1: Use 3 icons on the right, With the 'Close' Button on the Far-Right
 2: If you would like the pin on all desktops button, You need to place it on the left.
We apologize if you wanted a different configuration :(
EOF
            sleep 2
        fi
        ;;
    2)
        WINDECSTYLENAME=Classic
        WINDECSTYLECODE=__aurorae__svg__Catppuccin"$FLAVOURNAME"-Classic

        case "$FLAVOUR" in
            1) StoreAuroraeNo="2135228" ;;
            2) StoreAuroraeNo="2135226" ;;
            3) StoreAuroraeNo="2135224" ;;
            4) StoreAuroraeNo="2135222" ;;
            *) ;;
        esac

        if [ "$QUIET" -ne 1 ]; then
            cat <<EOF

Classic($WINDECSTYLE) decorations were selected.
EOF
        fi
        ;;
    *)
        echo "Not a valid Window decoration" >&2
        exit 1
        ;;
esac

# dependency checks run after the flavour/accent/decoration validation so a bad
# argument reports the right error even headless. only the full install needs the
# plasma tools; the build-only debug modes (color/aurorae/splash/cursor) don't.
[ "$LOCAL_CURSOR" -eq 1 ] || check_command_exists "wget"
[ "$LOCAL_CURSOR" -eq 1 ] || check_command_exists "unzip"
check_command_exists "sed"
check_command_exists "tar"
case "$DEBUGMODE" in
    global) check_command_exists "kpackagetool6" ;;
    "" | auto)
        check_command_exists "kpackagetool6"
        check_command_exists "kwriteconfig6"
        check_command_exists "plasma-apply-lookandfeel"
        ;;
    *) ;;
esac

BuildColorscheme() {
    # Add Metadata & Replace Accent in colors file
    # Selection text is dark (crust) on the accent. Latte's darkest accents
    # (red/mauve/blue) need white instead, crust is too low-contrast there.
    SELFG="17, 17, 27"
    if [ "$FLAVOURNAME" = "Latte" ]; then
        case "$ACCENTNAME" in
            Red | Mauve | Blue) SELFG="255, 255, 255" ;;
            *) ;;
        esac
    fi
    sed "s/--accentColor/$ACCENTCOLOR/g; s/--selFg/$SELFG/g; s/--flavour/$FLAVOURNAME/g; s/--accentName/$ACCENTNAME/g" ./Resources/Base.colors >./dist/base.colors
    # Hydrate Dummy colors according to Pallet
    ./Installer/color-build.sh -f "$FLAVOURNAME" -o ./dist/Catppuccin"$FLAVOURNAME$ACCENTNAME".colors -s ./dist/base.colors
}

BuildSplashScreen() {
    case "$FLAVOUR" in
        1) MANTLECOLOR="#181825" ;;
        2) MANTLECOLOR="#1e2030" ;;
        3) MANTLECOLOR="#292c3c" ;;
        4) MANTLECOLOR="#e6e9ef" ;;
        *) ;;
    esac

    # Hydrate Dummy colors according to Pallet
    ./Installer/color-build.sh -f "$FLAVOURNAME" -s ./Resources/splash-screen/contents/splash/images/busywidget.svg -o ./dist/"$SPLASHSCREENNAME"/contents/splash/images/_busywidget.svg
    # Replace Accent in colors file
    sed "s/REPLACE--ACCENT/$ACCENTCOLOR/g" ./dist/"$SPLASHSCREENNAME"/contents/splash/images/_busywidget.svg >./dist/"$SPLASHSCREENNAME"/contents/splash/images/busywidget.svg
    # Cleanup temporary file
    rm ./dist/"$SPLASHSCREENNAME"/contents/splash/images/_busywidget.svg

    # Hydrate Dummy colors according to Pallet (QML file)
    sed -e "s/REPLACE--MANTLE/$MANTLECOLOR/g" ./Resources/splash-screen/contents/splash/Splash.qml >./dist/"$SPLASHSCREENNAME"/contents/splash/Splash.qml
    # Add CTP Logo
    if [ "$FLAVOUR" -ne 4 ]; then
        cp ./Resources/splash-screen/contents/splash/images/Logo.png ./dist/"$SPLASHSCREENNAME"/contents/splash/images/Logo.png
    else
        cp ./Resources/splash-screen/contents/splash/images/Latte_Logo.png ./dist/"$SPLASHSCREENNAME"/contents/splash/images/Logo.png
    fi
    sed "s/--accentName/$ACCENTNAME/g; s/--flavour/$FLAVOURNAME/g" ./Resources/splash-screen/metadata.desktop >./dist/"$SPLASHSCREENNAME"/metadata.desktop
    sed "s/--accentName/$ACCENTNAME/g; s/--flavour/$FLAVOURNAME/g" ./Resources/splash-screen/metadata.json >./dist/"$SPLASHSCREENNAME"/metadata.json
    mkdir -p ./dist/"$SPLASHSCREENNAME"/contents/previews
    cp ./Resources/splash-previews/"$FLAVOURNAME".png ./dist/"$SPLASHSCREENNAME"/contents/previews/splash.png
    # cp ./Resources/splash-previews/"$FLAVOURNAME".png ./dist/"$SPLASHSCREENNAME"/contents/previews/preview.png
    cp -r ./dist/"$SPLASHSCREENNAME"/contents/splash/ "$LOOKANDFEELDIR"/"$GLOBALTHEMENAME"/contents/
    cp -r ./dist/"$SPLASHSCREENNAME"/contents/previews/* "$LOOKANDFEELDIR"/"$GLOBALTHEMENAME"/contents/previews/
}

InstallAuroraeTheme() {
    # Prepare Aurorae Theme Folder
    cp -r ./Resources/Aurorae/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME" ./dist/
    if [ "$FLAVOUR" -eq 4 ]; then
        cp ./Resources/Aurorae/Common/CatppuccinLatte-"$WINDECSTYLENAME"rc ./dist/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME"/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME"rc
    else
        cp ./Resources/Aurorae/Common/Catppuccin-"$WINDECSTYLENAME"rc ./dist/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME"/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME"rc
    fi

    log "Installing Aurorae Theme..."
    cp -r ./dist/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME"/ "$AURORAEDIR"
}

InstallGlobalTheme() {
    # Prepare Global Theme Folder
    cp -r ./Resources/LookAndFeel/Catppuccin-"$FLAVOURNAME"-Global ./dist/"$GLOBALTHEMENAME"
    mkdir -p ./dist/"$SPLASHSCREENNAME"/contents/splash/images

    # Hydrate Metadata with Pallet + Accent Info
    sed "s/--accentName/$ACCENTNAME/g; s/--flavour/$FLAVOURNAME/g; s/--StoreAuroraeNo/$StoreAuroraeNo/g" ./Resources/LookAndFeel/metadata.desktop >./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"/metadata.desktop
    sed "s/--accentName/$ACCENTNAME/g; s/--flavour/$FLAVOURNAME/g; s/--StoreAuroraeNo/$StoreAuroraeNo/g" ./Resources/LookAndFeel/metadata.json >./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"/metadata.json

    # Modify 'defaults' to set the correct Aurorae Theme
    sed "s/--cursorTheme/$CURSORTHEME/g; s/--lcflavour/$LCFLAVOUR/g; s/--lcaccentName/$LCACCENT/g; s/--accentName/$ACCENTNAME/g; s/--flavour/$FLAVOURNAME/g; s/--aurorae/$WINDECSTYLECODE/g" ./Resources/LookAndFeel/defaults >./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"/contents/defaults

    # Install Global Theme.
    # This refers to the QDBusConnection: error: could not send signal to service error
    # Which has had no effect in our testing on the working of this Installer.

    if [ "$QUIET" -ne 1 ]; then
        cat <<EOF

 WARNING: There might be some errors that might not affect the installer at all during this step, Please advise.

EOF
        sleep 1
    fi
    log "Installing Global Theme.."
    (
        cd ./dist || exit
        tar -czf "$GLOBALTHEMENAME".tar.gz "$GLOBALTHEMENAME"
        if [ "$QUIET" -eq 1 ]; then
            kpackagetool6 -t Plasma/LookAndFeel -i "$GLOBALTHEMENAME".tar.gz >/dev/null 2>&1 ||
                kpackagetool6 -t Plasma/LookAndFeel -u "$GLOBALTHEMENAME".tar.gz >/dev/null 2>&1
        else
            kpackagetool6 -t Plasma/LookAndFeel -i "$GLOBALTHEMENAME".tar.gz ||
                kpackagetool6 -t Plasma/LookAndFeel -u "$GLOBALTHEMENAME".tar.gz
        fi
    )

    # Build SplashScreen
    log "Building SplashScreen.."
    BuildSplashScreen
}

InstallColorscheme() {
    log "Building Colorscheme.."

    # Generate Color scheme
    BuildColorscheme

    # Install Colorscheme
    log "Installing Colorscheme.."
    mv ./dist/Catppuccin"$FLAVOURNAME$ACCENTNAME".colors "$COLORDIR"
}

GetCursor() {
    # Fetches cursors
    log "Downloading Catppuccin Cursors from Catppuccin/cursors..."
    [ "$QUIET" -eq 1 ] || sleep 2
    for cursor_zip in "$CURSORACCENT" "$CURSORDARK"; do
        if ! wget -q -P ./dist "https://github.com/catppuccin/cursors/releases/download/$CURSORVERSION/$cursor_zip.zip"; then
            invalid_arg "Could not download $cursor_zip.zip from catppuccin/cursors $CURSORVERSION. Check your connection or the cursors release page."
        fi
        if [ ! -s "./dist/$cursor_zip.zip" ]; then
            invalid_arg "Downloaded $cursor_zip.zip is empty; the cursors release $CURSORVERSION may have changed. Check the catppuccin/cursors store page."
        fi
    done
    (
        cd ./dist || exit
        unzip -q "$CURSORACCENT".zip
        unzip -q "$CURSORDARK".zip
    )
}

InstallCursor() {
    if [ "$LOCAL_CURSOR" -eq 1 ]; then
        LOCAL_CURSOR_SOURCE=$(cd "$LOCAL_CURSOR_PATH" && pwd -P)
        LOCAL_CURSOR_TARGET=$(cd "$CURSORDIR" && pwd -P)/$CURSORTHEME
        if [ "$LOCAL_CURSOR_SOURCE" != "$LOCAL_CURSOR_TARGET" ]; then
            rm -rf "${CURSORDIR:?}/$CURSORTHEME"
            cp -R "$LOCAL_CURSOR_PATH" "$CURSORDIR/$CURSORTHEME"
        fi
    else
        GetCursor
        rm -rf "${CURSORDIR:?}/$CURSORACCENT"
        rm -rf "${CURSORDIR:?}/$CURSORDARK"
        mv ./dist/"$CURSORACCENT" "$CURSORDIR"
        mv ./dist/"$CURSORDARK" "$CURSORDIR"
    fi
}

# Syntax [-q|--quiet] <Flavour> <Accent> <WindowDec> <Debug = aurorae/global/color/splash/cursor>
# splash and cursor debug modes fall through to the confirmation check below
# without setting this, so default it for set -u.
CONFIRMATION=""
case "$DEBUGMODE" in
    "")
        if [ "$QUIET" -eq 1 ]; then
            CONFIRMATION=Y
        else
            echo
            echo "Install $FLAVOURNAME $ACCENTNAME? with the $WINDECSTYLENAME window Decorations? [y/N]:"
            read -r CONFIRMATION || true
            clear_screen
        fi
        ;;
    auto)
        CONFIRMATION=Y
        ;;
    aurorae)
        InstallAuroraeTheme
        exit
        ;;
    global)
        InstallGlobalTheme
        exit
        ;;
    color)
        BuildColorscheme
        exit
        ;;
    splash)
        # Prepare Global Theme Folder
        cp -r ./Resources/LookAndFeel/Catppuccin-"$FLAVOURNAME"-Global ./dist/"$GLOBALTHEMENAME"
        mkdir -p ./dist/"$SPLASHSCREENNAME"/contents/splash/images
        mkdir -p "$LOOKANDFEELDIR"/"$GLOBALTHEMENAME"/contents/previews

        BuildSplashScreen
        ;;
    cursor) GetCursor ;;
    *) echo "Invalid Debug Mode" >&2 ;;
esac

if [ "$CONFIRMATION" = "Y" ] || [ "$CONFIRMATION" = "y" ]; then
    # Build and Install Aurorae Theme
    InstallAuroraeTheme

    # Build and Install Global Theme
    InstallGlobalTheme

    # Build Colorscheme
    InstallColorscheme

    log "Installing Catppuccin Cursor theme.."
    InstallCursor

    # Cleanup
    log "Cleaning up.."
    rm -r ./dist

    if [ "$DEBUGMODE" != "auto" ] && [ "$QUIET" -ne 1 ]; then
        # Apply theme
        log ""
        log "Do you want to apply theme? [Y/n]:"
        read -r CONFIRMATION || true
    fi

    if [ "$CONFIRMATION" = "Y" ] || [ "$CONFIRMATION" = "y" ] || [ "$CONFIRMATION" = "" ]; then
        # KWin's BorderSizeAuto=true overrides the look-and-feel BorderSize=None, so the
        # global theme alone can't set it. Write it directly for borderless windows.
        kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key BorderSizeAuto false
        plasma-apply-lookandfeel -a "$GLOBALTHEMENAME"
        if [ "$DEBUGMODE" != "auto" ]; then
            [ "$QUIET" -eq 1 ] || clear_screen
        fi
        # Some legacy apps still look in ~/.icons
        if [ "$QUIET" -ne 1 ]; then
            cat <<EOF
The cursors will fully apply once you log out
You may want to run the following in your terminal if you notice any inconsistencies for the cursor theme:
ln -s ~/.local/share/icons/ ~/.icons
EOF
        fi
    else
        log "You can apply theme at any time using system settings"
        [ "$QUIET" -eq 1 ] || sleep 1
    fi
else
    log "Exiting.."
fi
