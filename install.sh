#!/bin/sh

# Syntax [-q|--quiet] [-c|--local-cursor <path>] [-n|--no-cursor] <Flavour = 1-4 > <Accent = 1-14> <WindowDec = 1/2> <Debug = aurorae/global/color/splash/cursor>

set -eu

QUIET=0

LOCAL_CURSOR=0
LOCAL_CURSOR_PATH=""
LOCAL_CURSOR_NAME=""

NO_CURSOR=0

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
        -n | --no-cursor)
            NO_CURSOR=1
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

if [ "$NO_CURSOR" -eq 1 ] && [ "$DEBUGMODE" = "cursor" ]; then
    invalid_arg "Debug mode 'cursor' does not support --no-cursor."
fi

if [ "$LOCAL_CURSOR" -eq 1 ] && [ "$NO_CURSOR" -eq 1 ]; then
    invalid_arg "--local-cursor and --no-cursor are mutually exclusive."
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

# Every RGB value lives in generated/ now (rendered by Whiskers from the
# catppuccin crate); this only needs to resolve the number to a display name.
case "$ACCENT" in
    1) ACCENTNAME="Rosewater" ;;
    2) ACCENTNAME="Flamingo" ;;
    3) ACCENTNAME="Pink" ;;
    4) ACCENTNAME="Mauve" ;;
    5) ACCENTNAME="Red" ;;
    6) ACCENTNAME="Maroon" ;;
    7) ACCENTNAME="Peach" ;;
    8) ACCENTNAME="Yellow" ;;
    9) ACCENTNAME="Green" ;;
    10) ACCENTNAME="Teal" ;;
    11) ACCENTNAME="Sky" ;;
    12) ACCENTNAME="Sapphire" ;;
    13) ACCENTNAME="Blue" ;;
    14) ACCENTNAME="Lavender" ;;
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
[ "$LOCAL_CURSOR" -eq 1 ] || [ "$NO_CURSOR" -eq 1 ] || check_command_exists "wget"
[ "$LOCAL_CURSOR" -eq 1 ] || [ "$NO_CURSOR" -eq 1 ] || check_command_exists "unzip"
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

# generated/ is a required, tracked part of the repo (a stripped clone or a
# partial regenerate is otherwise a `cp: cannot stat` mid-install after
# partial XDG writes). fail cleanly here, before any destination write.
# aurorae/cursor debug modes never touch generated/, same scoping as the
# plasma-tool dependency checks above.
case "$DEBUGMODE" in
    aurorae | cursor) ;;
    *)
        for genpath in \
            "./generated/color-schemes/Catppuccin$FLAVOURNAME$ACCENTNAME.colors" \
            "./generated/look-and-feel/$WINDECSTYLENAME/Catppuccin-$FLAVOURNAME-$ACCENTNAME" \
            "./generated/splash/Catppuccin-$FLAVOURNAME-$ACCENTNAME-splash" \
            "./generated/splash-qml/Catppuccin$FLAVOURNAME-Splash.qml"; do
            [ -e "$genpath" ] || invalid_arg "Missing generated theme data; re-clone or run 'just build'."
        done
        ;;
esac

BuildColorscheme() {
    cp "./generated/color-schemes/Catppuccin$FLAVOURNAME$ACCENTNAME.colors" "./dist/Catppuccin$FLAVOURNAME$ACCENTNAME.colors"
}

BuildSplashScreen() {
    cp "./generated/splash/$SPLASHSCREENNAME/contents/splash/images/busywidget.svg" "./dist/$SPLASHSCREENNAME/contents/splash/images/busywidget.svg"
    # Splash.qml's only substitution (mantle hex) is flavour-scoped, not
    # accent-scoped, so it's rendered once per flavour, not once per combo.
    cp "./generated/splash-qml/Catppuccin$FLAVOURNAME-Splash.qml" "./dist/$SPLASHSCREENNAME/contents/splash/Splash.qml"
    # Add CTP Logo
    if [ "$FLAVOUR" -ne 4 ]; then
        cp ./Resources/splash-screen/contents/splash/images/Logo.png ./dist/"$SPLASHSCREENNAME"/contents/splash/images/Logo.png
    else
        cp ./Resources/splash-screen/contents/splash/images/Latte_Logo.png ./dist/"$SPLASHSCREENNAME"/contents/splash/images/Logo.png
    fi
    cp "./generated/splash/$SPLASHSCREENNAME/metadata.desktop" "./dist/$SPLASHSCREENNAME/metadata.desktop"
    cp "./generated/splash/$SPLASHSCREENNAME/metadata.json" "./dist/$SPLASHSCREENNAME/metadata.json"
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

    cp "./generated/look-and-feel/$WINDECSTYLENAME/Catppuccin-$FLAVOURNAME-$ACCENTNAME/metadata.desktop" "./dist/Catppuccin-$FLAVOURNAME-$ACCENTNAME/metadata.desktop"
    cp "./generated/look-and-feel/$WINDECSTYLENAME/Catppuccin-$FLAVOURNAME-$ACCENTNAME/metadata.json" "./dist/Catppuccin-$FLAVOURNAME-$ACCENTNAME/metadata.json"

    # defaults is baked with the accent's own cursor set, which is correct for
    # every non--c install. --local-cursor's basename is only known here, at
    # runtime, so it's the one line rewritten in place rather than pre-rendered.
    cp "./generated/look-and-feel/$WINDECSTYLENAME/Catppuccin-$FLAVOURNAME-$ACCENTNAME/contents/defaults" "./dist/Catppuccin-$FLAVOURNAME-$ACCENTNAME/contents/defaults"
    defaults="./dist/Catppuccin-$FLAVOURNAME-$ACCENTNAME/contents/defaults"
    if [ "$LOCAL_CURSOR" -eq 1 ]; then
        while IFS= read -r line; do
            case $line in
                cursorTheme=*) printf '%s\n' "cursorTheme=$CURSORTHEME" ;;
                *) printf '%s\n' "$line" ;;
            esac
        done <"$defaults" >"$defaults.tmp" && mv "$defaults.tmp" "$defaults"
    elif [ "$NO_CURSOR" -eq 1 ]; then
        # plasma-apply-lookandfeel applies every key in defaults verbatim, so a
        # baked cursorTheme would still overwrite the user's current cursor even
        # though no cursor was ever installed. drop the whole section instead.
        in_section=0
        while IFS= read -r line; do
            case $line in
                '[kcminputrc][Mouse]')
                    in_section=1
                    continue
                    ;;
                '['*)
                    in_section=0
                    ;;
                *) ;;
            esac
            [ "$in_section" -eq 1 ] && continue
            printf '%s\n' "$line"
        done <"$defaults" >"$defaults.tmp" && mv "$defaults.tmp" "$defaults"
    fi

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

    if [ "$NO_CURSOR" -eq 1 ]; then
        log "Skipping cursor install (--no-cursor).."
    else
        log "Installing Catppuccin Cursor theme.."
        InstallCursor
    fi

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
        if [ "$QUIET" -ne 1 ] && [ "$NO_CURSOR" -ne 1 ]; then
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
