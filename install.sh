#!/bin/sh

# Syntax <Flavour = 1-4 > <Accent = 1-14> <WindowDec = 1/2> <Debug = aurorae/global/color/splash/cursor>

check_command_exists() {
  command_name="${*}"

  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Error: Dependency '$command_name' is not met."
    echo "Exiting.."
    exit 1
  fi
}

check_command_exists "wget"
check_command_exists "sed"
check_command_exists "unzip"
# check_command_exists "lookandfeeltool"

COLORDIR="${XDG_DATA_HOME:-$HOME/.local/share}/color-schemes"
AURORAEDIR="${XDG_DATA_HOME:-$HOME/.local/share}/aurorae/themes"
LOOKANDFEELDIR="${XDG_DATA_HOME:-$HOME/.local/share}/plasma/look-and-feel"
CURSORDIR="${XDG_DATA_HOME:-$HOME/.local/share}/icons"

echo "Creating theme directories.."
# mkdir -p "$COLORDIR" "$AURORAEDIR" "$LOOKANDFEELDIR" "$CURSORDIR"
mkdir ./dist

# Fast install
FLAVOUR="$1"
ACCENT="$2"
WINDECSTYLE="$3"
DEBUGMODE="$4"

clear

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
    clear
fi

case "$FLAVOUR" in
    1) FLAVOURNAME="Mocha" ;;
    2) FLAVOURNAME="Macchiato" ;;
    3) FLAVOURNAME="Frappe" ;;
    4) FLAVOURNAME="Latte" ;;
    *)
        echo "Not a valid flavour name: $FLAVOUR"
        exit 1
        ;;
esac
echo "$FLAVOURNAME($FLAVOUR) palette was selected."
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
    clear
fi

# Sets accent based on the palette selected (Best to fold this in your respective editor)
case "$ACCENT" in
    1)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="245,224,220" ;;
            2) ACCENTCOLOR="244,219,214" ;;
            3) ACCENTCOLOR="242,213,207" ;;
            4) ACCENTCOLOR="220,138,120" ;;
        esac
        ACCENTNAME="Rosewater"
        ;;
    2)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="242,205,205" ;;
            2) ACCENTCOLOR="240,198,198" ;;
            3) ACCENTCOLOR="238,190,190" ;;
            4) ACCENTCOLOR="221,120,120" ;;
        esac
        ACCENTNAME="Flamingo"
        ;;
    3)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="245,194,231" ;;
            2) ACCENTCOLOR="245,189,230" ;;
            3) ACCENTCOLOR="244,184,228" ;;
            4) ACCENTCOLOR="234,118,203" ;;
        esac
        ACCENTNAME="Pink"
        ;;
    4)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="203,166,247" ;;
            2) ACCENTCOLOR="198,160,246" ;;
            3) ACCENTCOLOR="202,158,230" ;;
            4) ACCENTCOLOR="136,57,239" ;;
        esac
        ACCENTNAME="Mauve"
        ;;
    5)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="243,139,168" ;;
            2) ACCENTCOLOR="237,135,150" ;;
            3) ACCENTCOLOR="231,130,132" ;;
            4) ACCENTCOLOR="210,15,57" ;;
        esac
        ACCENTNAME="Red"
        ;;
    6)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="235,160,172" ;;
            2) ACCENTCOLOR="238,153,160" ;;
            3) ACCENTCOLOR="234,153,156" ;;
            4) ACCENTCOLOR="230,69,83" ;;
        esac
        ACCENTNAME="Maroon"
        ;;
    7)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="250,179,135" ;;
            2) ACCENTCOLOR="245,169,127" ;;
            3) ACCENTCOLOR="239,159,118" ;;
            4) ACCENTCOLOR="254,100,11" ;;
        esac
        ACCENTNAME="Peach"
        ;;
    8)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="249,226,175" ;;
            2) ACCENTCOLOR="238,212,159" ;;
            3) ACCENTCOLOR="229,200,144" ;;
            4) ACCENTCOLOR="223,142,29" ;;
        esac
        ACCENTNAME="Yellow"
        ;;
    9)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="166,227,161" ;;
            2) ACCENTCOLOR="166,218,149" ;;
            3) ACCENTCOLOR="166,209,137" ;;
            4) ACCENTCOLOR="64,160,43" ;;
        esac
        ACCENTNAME="Green"
        ;;
    10)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="148,226,213" ;;
            2) ACCENTCOLOR="139,213,202" ;;
            3) ACCENTCOLOR="129,200,190" ;;
            4) ACCENTCOLOR="23,146,153" ;;
        esac
        ACCENTNAME="Teal"
        ;;
    11)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="137,220,235" ;;
            2) ACCENTCOLOR="145,215,227" ;;
            3) ACCENTCOLOR="153,209,219" ;;
            4) ACCENTCOLOR="4,165,229" ;;
        esac
        ACCENTNAME="Sky"
        ;;
    12)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="116,199,236" ;;
            2) ACCENTCOLOR="125,196,228" ;;
            3) ACCENTCOLOR="133,193,220" ;;
            4) ACCENTCOLOR="32,159,181" ;;
        esac
        ACCENTNAME="Sapphire"
        ;;
    13)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="137,180,250" ;;
            2) ACCENTCOLOR="138,173,244" ;;
            3) ACCENTCOLOR="140,170,238" ;;
            4) ACCENTCOLOR="30,102,245" ;;
        esac
        ACCENTNAME="Blue"
        ;;
    14)
        case "$FLAVOUR" in
            1) ACCENTCOLOR="180,190,254" ;;
            2) ACCENTCOLOR="183,189,248" ;;
            3) ACCENTCOLOR="186,187,241" ;;
            4) ACCENTCOLOR="114,135,253" ;;
        esac
        ACCENTNAME="Lavender"
        ;;
    *)
        echo "Not a valid accent: $ACCENT"
        exit 1
        ;;
esac
echo "$ACCENTNAME($ACCENT) accent color was selected."

GLOBALTHEMENAME="Catppuccin-$FLAVOURNAME-$ACCENTNAME"
SPLASHSCREENNAME="Catppuccin-$FLAVOURNAME-$ACCENTNAME-splash"

if [ -z "$3" ]; then
    cat <<EOF

Choose window decoration style -
    1. Modern (Mixed)
    2. Classic (MacOS like)
EOF
    read -r WINDECSTYLE
    clear
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
        esac

        cat <<EOF

Modern($WINDECSTYLE) decorations were selected.
These decorations have a few rules that may cause issues.
 1: Use 3 icons on the right, With the 'Close' Button on the Far-Right
 2: If you would like the pin on all desktops button, You need to place it on the left.
We apologize if you wanted a different configuration :(
EOF
        sleep 2
        ;;
    2)
        WINDECSTYLENAME=Classic
        WINDECSTYLECODE=__aurorae__svg__Catppuccin"$FLAVOURNAME"-Classic

        case "$FLAVOUR" in
            1) StoreAuroraeNo="2135228" ;;
            2) StoreAuroraeNo="2135226" ;;
            3) StoreAuroraeNo="2135224" ;;
            4) StoreAuroraeNo="2135222" ;;
        esac

		cat <<EOF

Classic($WINDECSTYLE) decorations were selected.
EOF
        ;;
    *) echo "Not a valid Window decoration" ;;
esac

BuildColorscheme() {
    # Add Metadata & Replace Accent in colors file
    sed "s/--accentColor/$ACCENTCOLOR/g; s/--flavour/$FLAVOURNAME/g; s/--accentName/$ACCENTNAME/g" ./Resources/Base.colors > ./dist/base.colors
    # Hydrate Dummy colors according to Pallet
    ./Installer/color-build.sh -f "$FLAVOURNAME" -o ./dist/Catppuccin"$FLAVOURNAME$ACCENTNAME".colors -s ./dist/base.colors
}

BuildSplashScreen() {
    case "$FLAVOUR" in
        1) MANTLECOLOR="#181825" ;;
        2) MANTLECOLOR="#1e2030" ;;
        3) MANTLECOLOR="#292c3c" ;;
        4) MANTLECOLOR="#e6e9ef" ;;
    esac

    # Hydrate Dummy colors according to Pallet
    FLAVOURNAME="$FLAVOURNAME" ./Installer/color-build.sh -s ./Resources/splash-screen/contents/splash/images/busywidget.svg -o ./dist/"$SPLASHSCREENNAME"/contents/splash/images/_busywidget.svg
    # Replace Accent in colors file
    sed "s/REPLACE--ACCENT/$ACCENTCOLOR/g" ./dist/"$SPLASHSCREENNAME"/contents/splash/images/_busywidget.svg > ./dist/"$SPLASHSCREENNAME"/contents/splash/images/busywidget.svg
    # Cleanup temporary file
    rm ./dist/"$SPLASHSCREENNAME"/contents/splash/images/_busywidget.svg

    # Hydrate Dummy colors according to Pallet (QML file)
    sed -e s/REPLACE--MANTLE/"$MANTLECOLOR"/g ./Resources/splash-screen/contents/splash/Splash.qml > ./dist/"$SPLASHSCREENNAME"/contents/splash/Splash.qml
    # Add CTP Logo
    if [ "$FLAVOUR" -ne 4 ]; then
        cp ./Resources/splash-screen/contents/splash/images/Logo.png ./dist/"$SPLASHSCREENNAME"/contents/splash/images/Logo.png
    else
        cp ./Resources/splash-screen/contents/splash/images/Latte_Logo.png ./dist/"$SPLASHSCREENNAME"/contents/splash/images/Logo.png
    fi

    #sed "s/--accentName/$ACCENTNAME/g; s/--flavour/$FLAVOURNAME/g" ./Resources/splash-screen/metadata.desktop > ./dist/"$SPLASHSCREENNAME"/metadata.desktop
	#sed "s/--accentName/$ACCENTNAME/g; s/--flavour/$FLAVOURNAME/g" ./Resources/splash-screen/metadata.json > ./dist/"$SPLASHSCREENNAME"/metadata.json
    mkdir ./dist/"$SPLASHSCREENNAME"/contents/previews
    cp ./Resources/splash-previews/"$FLAVOURNAME".png ./dist/"$SPLASHSCREENNAME"/contents/previews/splash.png
    # cp ./Resources/splash-previews/"$FLAVOURNAME".png ./dist/"$SPLASHSCREENNAME"/contents/previews/preview.png
#    cp -r ./dist/"$SPLASHSCREENNAME"/contents/splash/ "$LOOKANDFEELDIR"/"$GLOBALTHEMENAME"/contents/
    #cp -r ./dist/"$SPLASHSCREENNAME"/contents/previews/* "$LOOKANDFEELDIR"/"$GLOBALTHEMENAME"/contents/previews/
}

InstallAuroraeTheme() {
	# Prepare Aurorae Theme Folder
	cp -r ./Resources/Aurorae/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME" ./dist/
    if [ "$FLAVOUR" -eq 4 ]; then
		cp ./Resources/Aurorae/Common/CatppuccinLatte-"$WINDECSTYLENAME"rc ./dist/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME"/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME"rc
	else
		cp ./Resources/Aurorae/Common/Catppuccin-"$WINDECSTYLENAME"rc ./dist/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME"/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME"rc
	fi

	echo "Installing Aurorae Theme..."
	#cp -r ./dist/Catppuccin"$FLAVOURNAME"-"$WINDECSTYLENAME"/ "$AURORAEDIR"
}

InstallGlobalTheme() {
    # Prepare Global Theme Folder
    cp -r ./Resources/LookAndFeel/Catppuccin-"$FLAVOURNAME"-Global ./dist/"$GLOBALTHEMENAME"
    mkdir -p ./dist/"$SPLASHSCREENNAME"/contents/splash/images

    # Hydrate Metadata with Pallet + Accent Info
    sed "s/--accentName/$ACCENTNAME/g; s/--flavour/$FLAVOURNAME/g; s/--StoreAuroraeNo/$StoreAuroraeNo/g" ./Resources/LookAndFeel/metadata.desktop > ./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"/metadata.desktop
	sed "s/--accentName/$ACCENTNAME/g; s/--flavour/$FLAVOURNAME/g; s/--StoreAuroraeNo/$StoreAuroraeNo/g" ./Resources/LookAndFeel/metadata.json > ./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"/metadata.json

    # Modify 'defaults' to set the correct Aurorae Theme
    sed "s/--accentName/$ACCENTNAME/g; s/--flavour/$FLAVOURNAME/g; s/--aurorae/$WINDECSTYLECODE/g" ./Resources/LookAndFeel/defaults > ./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"/contents/defaults



    # Install Global Theme.
    # This refers to the QDBusConnection: error: could not send signal to service error
    # Which has had no effect in our testing on the working of this Installer.

    cat <<EOF

 WARNING: There might be some errors that might not affect the installer at all during this step, Please advise.

EOF
    sleep 1
    echo "Installing Global Theme.."
    # (
    #     cd ./dist || exit
    #     tar -cf "$GLOBALTHEMENAME".tar.gz "$GLOBALTHEMENAME"
    #     kpackagetool6 -i "$GLOBALTHEMENAME".tar.gz
    #     cp -r "$GLOBALTHEMENAME" "$LOOKANDFEELDIR"
    # )

    # Build SplashScreen
    echo "Building SplashScreen.."
    BuildSplashScreen
}

InstallColorscheme() {
    echo "Building Colorscheme.."

    # Generate Color scheme
    BuildColorscheme

    # Install Colorscheme
    echo "Installing Colorscheme.."
   # mv ./dist/Catppuccin"$FLAVOURNAME$ACCENTNAME".colors "$COLORDIR"
}

GetCursor() {
    # Fetches cursors
    echo "Downloading Catppuccin Cursors from Catppuccin/cursors..."
    sleep 2
    wget -q -P ./dist https://github.com/catppuccin/cursors/releases/download/v0.2.0/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"-Cursors.zip
    wget -q -P ./dist https://github.com/catppuccin/cursors/releases/download/v0.2.0/Catppuccin-"$FLAVOURNAME"-Dark-Cursors.zip
    (
        cd ./dist || exit
        unzip -q Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"-Cursors.zip
        unzip -q Catppuccin-"$FLAVOURNAME"-Dark-Cursors.zip
    )
}

InstallCursor() {
    GetCursor
    mv ./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"-Cursors "$CURSORDIR"
    mv ./dist/Catppuccin-"$FLAVOURNAME"-Dark-Cursors "$CURSORDIR"
}

# Syntax <Flavour> <Accent> <WindowDec> <Debug = aurorae/global/color/splash/cursor>
case "$DEBUGMODE" in
    "")
        echo
        echo "Install $FLAVOURNAME $ACCENTNAME? with the $WINDECSTYLENAME window Decorations? [y/N]:"
        read -r CONFIRMATION
        clear
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
        GLOBALTHEMENAME="Catppuccin-$FLAVOURNAME-$ACCENTNAME"

        cp -r ./Resources/LookAndFeel/Catppuccin-"$FLAVOURNAME"-Global ./dist/"$GLOBALTHEMENAME"
        mkdir -p ./dist/"$GLOBALTHEMENAME"/contents/splash/images

        BuildSplashScreen
        ;;
    cursor) GetCursor ;;
    *) echo "Invalid Debug Mode" ;;
esac

if [ "$CONFIRMATION" = "Y" ] || [ "$CONFIRMATION" = "y" ]; then
	# Build and Install Aurorae Theme
    InstallAuroraeTheme

    # Build and Install Global Theme
    InstallGlobalTheme

    # Build Colorscheme
    InstallColorscheme

    echo "Installing Catppuccin Cursor theme.."

    # Cleanup
    echo "Cleaning up.."

    # Apply theme
    echo
    echo "Do you want to apply theme? [y/N]:"
    # read -r CONFIRMATION

#     if [ "$CONFIRMATION" = "Y" ] || [ "$CONFIRMATION" = "y" ]; then
#         lookandfeeltool -a "$GLOBALTHEMENAME"
#         clear
#         # Some legacy apps still look in ~/.icons
#         cat <<EOF
# The cursors will fully apply once you log out
# You may want to run the following in your terminal if you notice any inconsistencies for the cursor theme:
# ln -s ~/.local/share/icons/ ~/.icons
# EOF
#     else
#         echo "You can apply theme at any time using system settings"
#         sleep 1
#     fi
else
    echo "Exiting.."
fi
