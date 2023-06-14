#!/usr/bin/env bash

# Syntax <Flavour = 1-4 > <Accent = 1-14> <WindowDec = 1/2> <Debug = global/color/splash/cursor>

COLORDIR=~/.local/share/color-schemes
AURORAEDIR=~/.local/share/aurorae/themes
LOOKANDFEELDIR=~/.local/share/plasma/look-and-feel
DESKTOPTHEMEDIR=~/.local/share/plasma/desktoptheme
CURSORDIR=~/.local/share/icons

echo "Creating theme directories.."
mkdir -p $COLORDIR
mkdir -p $AURORAEDIR
mkdir -p $LOOKANDFEELDIR
mkdir -p $DESKTOPTHEMEDIR
mkdir -p $CURSORDIR
mkdir ./dist

# Fast install
FLAVOUR="$1"
ACCENT="$2"
WINDECSTYLE="$3"

DEBUGMODE="$4"

clear

if [[ "$1" == "" ]]; then
    echo ""
    echo "Choose flavor out of -
    1. Mocha
    2. Macchiato
    3. Frappé
    4. Latte
    (Type the number corresponding to said pallet)
    "
    read -r FLAVOUR
    clear
fi

if [[ $FLAVOUR == "1" ]]; then
    echo "The pallet Mocha(1) was selected";
    FLAVOURNAME="Mocha";
elif [[ $FLAVOUR == "2" ]]; then
    echo "The pallet Macchiato(2) was selected";
    FLAVOURNAME="Macchiato";
elif [[ $FLAVOUR == "3" ]]; then
    echo "The pallet Frappe(3) was selected";
    FLAVOURNAME="Frappe";
elif [[ $FLAVOUR == "4" ]]; then
    echo "The pallet Latte(4) was selected";
    FLAVOURNAME="Latte";
else echo "Not a valid flavour name" && exit;
fi
echo ""

if [[ "$2" == "" ]]; then
    echo "Choose an accent -
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
    "
    read -r ACCENT
    clear
fi

# Sets accent based on the pallet selected (Best to fold this in your respective editor)
if [[ $ACCENT == "1" ]]; then

    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="245,224,220"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="244,219,214"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="242,213,207"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="220,138,120"
    fi
    echo "Accent Rosewater(1) was selected!"
    ACCENTNAME="Rosewater"
elif [[ $ACCENT == "2" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="242,205,205"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="240,198,198"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="238,190,190"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="221,120,120"
    fi
    echo "Accent Flamingo(2) was selected!"
    ACCENTNAME="Flamingo"
elif [[ $ACCENT == "3" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="245,194,231"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="245,189,230"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="244,184,228"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="234,118,203"
    fi
    echo "Accent Pink(3) was selected!"
    ACCENTNAME="Pink"
elif [[ $ACCENT == "4" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="203,166,247"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="198,160,246"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="202,158,230"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="136,57,239"
    fi
    echo "Accent Mauve(4) was selected!"
    ACCENTNAME="Mauve"
elif [[ $ACCENT == "5" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="243,139,168"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="237,135,150"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="231,130,132"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="210,15,57"
    fi
    echo "Accent Red(5) was selected!"
    ACCENTNAME="Red"
elif [[ $ACCENT == "6" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="235,160,172"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="238,153,160"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="234,153,156"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="230,69,83"
    fi
    echo "Accent Maroon(6) was selected!"
    ACCENTNAME="Maroon"
elif [[ $ACCENT == "7" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="250,179,135"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="245,169,127"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="239,159,118"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="254,100,11"
    fi
    echo "Accent Peach(7) was selected!"
    ACCENTNAME="Peach"
elif [[ $ACCENT == "8" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="249,226,175"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="238,212,159"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="229,200,144"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="223,142,29"
    fi
    echo "Accent Yellow(8) was selected!"
    ACCENTNAME="Yellow"
elif [[ $ACCENT == "9" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="166,227,161"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="166,218,149"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="166,209,137"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="64,160,43"
    fi
    echo "Accent Green(9) was selected!"
    ACCENTNAME="Green"
elif [[ $ACCENT == "10" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="148,226,213"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="139,213,202"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="129,200,190"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="23,146,153"
    fi
    echo "Accent Teal(10) was selected!"
    ACCENTNAME="Teal"
elif [[ $ACCENT == "11" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="137,220,235"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="145,215,227"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="153,209,219"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="4,165,229"
    fi
    echo "Accent Sky(11) was selected!"
    ACCENTNAME="Sky"
elif [[ $ACCENT == "12" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="116,199,236"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="125,196,228"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="133,193,220"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="32,159,181"
    fi
    echo "Accent Sapphire(12) was selected!"
    ACCENTNAME="Sapphire"
elif [[ $ACCENT == "13" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="137,180,250"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="138,173,244"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="140,170,238"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="30,102,245"
    fi
    echo "Accent Blue(13) was selected!"
    ACCENTNAME="Blue"
elif [[ $ACCENT == "14" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR="180,190,254"
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR="183,189,248"
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR="186,187,241"
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR="114,135,253"
    fi
    echo "Accent Lavender(14) was selected!"
    ACCENTNAME="Lavender"
else echo "Not a valid accent" && exit
fi

GLOBALTHEMENAME="Catppuccin-$FLAVOURNAME-$ACCENTNAME"
SPLASHSCREENNAME="Catppuccin-$FLAVOURNAME-$ACCENTNAME-splash"

if [[ "$3" == "" ]]; then
    echo "Choose window decoration style -
    1. Modern (Mixed)
    2. Classic (MacOS like)
    "
    read -r WINDECSTYLE
    clear
fi

if [[ $WINDECSTYLE == "1" ]]; then
    WINDECSTYLENAME=Modern
    WINDECSTYLECODE=__aurorae__svg__Catppuccin"$FLAVOURNAME"-Modern

    if [[ $FLAVOUR == "1" ]]; then
    StoreAuroraeNo="2023219";
    elif [[ $FLAVOUR == "2" ]]; then
    StoreAuroraeNo="2023220";
    elif [[ $FLAVOUR == "3" ]]; then
    StoreAuroraeNo="2023222";
    elif [[ $FLAVOUR == "4" ]]; then
    StoreAuroraeNo="2023224";
    fi

    echo "Hey! thanks for picking 'Modern', this one has a few rules or else it might break
 1: Use 3 icons on the right, With the 'Close' Button on the Far-Right
 2: If you would like the pin on all desktops button, You need to place it on the left."
    echo "We apologize if you wanted a different configuration :("
    sleep 2

elif [[ $WINDECSTYLE == "2" ]]; then
    WINDECSTYLENAME=Classic
    WINDECSTYLECODE=__aurorae__svg__Catppuccin"$FLAVOURNAME"-Classic

    if [[ $FLAVOUR == "1" ]]; then
    StoreAuroraeNo="2023180";
    elif [[ $FLAVOUR == "2" ]]; then
    StoreAuroraeNo="2023202";
    elif [[ $FLAVOUR == "3" ]]; then
    StoreAuroraeNo="2023203";
    elif [[ $FLAVOUR == "4" ]]; then
    StoreAuroraeNo="2023217";
    fi

else
    echo "Not a valid Window decoration"
fi

function ModifyLightlyPlasma {

    rm -rf $DESKTOPTHEMEDIR/lightly-plasma-git/icons/*
    rm -rf $DESKTOPTHEMEDIR/lightly-plasma-git/translucent
    rm $DESKTOPTHEMEDIR/lightly-plasma-git/widgets/tabbar.svgz
    rm $DESKTOPTHEMEDIR/lightly-plasma-git/dialogs/background.svgz

    # Copy Patches
    cp $DESKTOPTHEMEDIR/lightly-plasma-git/solid/* $DESKTOPTHEMEDIR/lightly-plasma-git -Rf
    cp ./Patches/glowbar.svg $DESKTOPTHEMEDIR/lightly-plasma-git/widgets -rf
    cp ./Patches/background.svg $DESKTOPTHEMEDIR/lightly-plasma-git/widgets -rf
    cp ./Patches/panel-background.svgz $DESKTOPTHEMEDIR/lightly-plasma-git/widgets

    # Modify description to state that it has been modified by the KDE Catppuccin Installer
    sed -e s/A\ plasma\ style\ with\ close\ to\ the\ look\ of\ the\ newest\ Lightly./*MODIFIED\ BY\ CATPPUCCIN\ KDE\ INSTALLER*\ A\ plasma\ style\ with\ close\ to\ the\ look\ of\ the\ newest\ Lightly./g $DESKTOPTHEMEDIR/lightly-plasma-git/metadata.desktop >> $DESKTOPTHEMEDIR/lightly-plasma-git/newMetadata.desktop
    cp -f $DESKTOPTHEMEDIR/metadata.desktop $DESKTOPTHEMEDIR/lightly-plasma-git/metadata.desktop && rm $DESKTOPTHEMEDIR/metadata.desktop
}

function BuildColorscheme {

    # Add Metadata & Replace Accent in colors file
    sed -e s/--accentColor/$ACCENTCOLOR/g -e s/--flavour/$FLAVOURNAME/g -e s/--accentName/$ACCENTNAME/g ./Resources/Base.colors > ./dist/base.colors
    # Hydrate Dummy colors according to Pallet
    FLAVOURNAME=$FLAVOURNAME ./Installer/color-build.sh -o ./dist/Catppuccin$FLAVOURNAME$ACCENTNAME.colors -s ./dist/base.colors
}

function BuildSplashScreen {

    if [[ $FLAVOUR == "1" ]]; then
        MANTLECOLOR=#181825
    elif [[ $FLAVOUR == "2" ]]; then
        MANTLECOLOR=#1e2030
    elif [[ $FLAVOUR == "3" ]]; then
        MANTLECOLOR=#292c3c
    elif [[ $FLAVOUR == "4" ]]; then
        MANTLECOLOR=#e6e9ef
    fi

    # Hydrate Dummy colors according to Pallet
    FLAVOURNAME=$FLAVOURNAME ./Installer/color-build.sh -s ./Resources/splash-screen/contents/splash/images/busywidget.svg -o ./dist/$SPLASHSCREENNAME/contents/splash/images/_busywidget.svg
    # Replace Accent in colors file
    sed ./dist/"$SPLASHSCREENNAME"/contents/splash/images/_busywidget.svg -e s/REPLACE--ACCENT/$ACCENTCOLOR/g > ./dist/"$SPLASHSCREENNAME"/contents/splash/images/busywidget.svg
    # Cleanup temporary file
    rm ./dist/"$SPLASHSCREENNAME"/contents/splash/images/_busywidget.svg

    # Hydrate Dummy colors according to Pallet (QML file)
    sed -e s/REPLACE--MANTLE/"$MANTLECOLOR"/g ./Resources/splash-screen/contents/splash/Splash.qml > ./dist/"$SPLASHSCREENNAME"/contents/splash/Splash.qml
    # Add CTP Logo
    if [[ $FLAVOUR != "4" ]]; then
        cp ./Resources/splash-screen/contents/splash/images/Logo.png ./dist/"$SPLASHSCREENNAME"/contents/splash/images/Logo.png
    else
        cp ./Resources/splash-screen/contents/images/Latte_Logo.png ./dist/"$SPLASHSCREENNAME"/contents/splash/images/Logo.png
    fi
    sed -e s/--accentName/"$ACCENTNAME"/g -e s/--flavour/"$FLAVOURNAME"/g ./Resources/splash-screen/metadata.desktop > ./dist/$SPLASHSCREENNAME/metadata.desktop
    cp -r ./dist/"$SPLASHSCREENNAME" ~/.local/share/plasma/look-and-feel/
}

function InstallGlobalTheme {

    # Prepare Global Theme Folder
    cp -r ./Resources/LookAndFeel/Catppuccin-"$FLAVOURNAME"-Global ./dist/"$GLOBALTHEMENAME"
    mkdir -p ./dist/"$SPLASHSCREENNAME"/contents/splash/images

    # Hydrate Metadata with Pallet + Accent Info
    sed -e s/--accentName/"$ACCENTNAME"/g -e s/--flavour/"$FLAVOURNAME"/g -e s/--StoreAuroraeNo/"$StoreAuroraeNo"/g ./Resources/LookAndFeel/metadata.desktop > ./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"/metadata.desktop

    # Modify 'defaults' to set the correct Aurorae Theme
    sed -e s/--accentName/"$ACCENTNAME"/g -e s/--flavour/"$FLAVOURNAME"/g -e s/--aurorae/"$WINDECSTYLECODE"/g ./Resources/LookAndFeel/defaults > ./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"/contents/defaults

    # Build SplashScreen
    echo "Building SplashScreen.."
    BuildSplashScreen

    # Install Global Theme.
    # This refers to the QDBusConnection: error: could not send signal to service error
    # Which has had no effect in our testing on the working of this Installer.

    echo "
 WARNING: There might be some errors that might not affect the installer at all during this step, Please advise.
    "
    sleep 1
    echo "Installing Global Theme.."
    cd ./dist && tar -cf "$GLOBALTHEMENAME".tar.gz "$GLOBALTHEMENAME"
    kpackagetool5 -i "$GLOBALTHEMENAME".tar.gz
    cd ..

    if [[ ! -d "$DESKTOPTHEMEDIR/lightly-plasma-git/" ]]; then
        clear
        echo ""
        echo "Installation failed, could not fetch the lightly plasma theme lightly-plasma-git from store.kde.org"
        echo "Here are some things you can do to try fixing this:"
        echo " 1: Rerunning the install script"
        echo " 2: Check your intenet connection"
        echo " 3: See if https://store.kde.org is blocked"
        echo " 4: Manually installing Lightly-Plasma from https://pling.com/p/1879921/"
        echo ""
        echo "Would you like to install Catppuccin/KDE without lightly plasma? [y/n]:"
        read -r CONFIRMATION
        if [[ $CONFIRMATION == "N" ]] || [[ $CONFIRMATION == "n" ]]; then
            echo ""
            echo "Exiting..." && exit
        fi
        echo ""
        echo "Continuing without lightly plasma.."
    else
        echo "Modifying lightly plasma theme.."
        ModifyLightlyPlasma
    fi
}

function InstallColorscheme {
    echo "Building Colorscheme.."

    # Generate Color scheme
    BuildColorscheme

    # Install Colorscheme
    echo "Installing Colorscheme.."
    mv ./dist/Catppuccin"$FLAVOURNAME$ACCENTNAME".colors $COLORDIR
}

function GetCursor {
    # Fetches cursors
    echo "Downloading Catppuccin Cursors from Catppuccin/cursors..."
    sleep 1.5
    wget -P ./dist https://github.com/catppuccin/cursors/releases/download/v0.2.0/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"-Cursors.zip
    wget -P ./dist https://github.com/catppuccin/cursors/releases/download/v0.2.0/Catppuccin-"$FLAVOURNAME"-Dark-Cursors.zip
    cd ./dist && unzip Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"-Cursors.zip
    unzip Catppuccin-"$FLAVOURNAME"-Dark-Cursors.zip
    cd ..
}

function InstallCursor {
    GetCursor
    mv ./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"-Cursors $CURSORDIR
    mv ./dist/Catppuccin-"$FLAVOURNAME"-Dark-Cursors $CURSORDIR
}

# Syntax <Flavour> <Accent> <WindowDec> <Debug = global/color/splash/cursor>
if [[ $DEBUGMODE == "" ]]; then
    echo ""
    echo "Install $FLAVOURNAME $ACCENTNAME? with the $WINDECSTYLENAME window Decorations? [y/n]:"
    read -r CONFIRMATION
    clear
elif [[ $DEBUGMODE == "global" ]]; then
    InstallGlobalTheme
    exit
elif [[ $DEBUGMODE == "color" ]]; then
    BuildColorscheme
    exit
elif [[ $DEBUGMODE == "splash" ]]; then
    # Prepare Global Theme Folder
    GLOBALTHEMENAME="Catppuccin-$FLAVOURNAME-$ACCENTNAME"

    cp -r ./Resources/LookAndFeel/Catppuccin-"$FLAVOURNAME"-Global ./dist/"$GLOBALTHEMENAME"
    mkdir -p ./dist/"$GLOBALTHEMENAME"/contents/splash/images

    BuildSplashScreen
elif [[ $DEBUGMODE == "cursor" ]]; then
    GetCursor
else
    echo "Invalid Debug Mode"
fi

if [[ $CONFIRMATION == "Y" ]] || [[ $CONFIRMATION == "y" ]]; then

    # Build and Install Global Theme
    InstallGlobalTheme

    # Build Colorscheme
    InstallColorscheme

    echo "Installing Catppuccin Cursor theme.."
    InstallCursor

    # Cleanup
    echo "Cleaning up.."
    rm -rf ./dist

    # Apply theme
    echo ""
    echo "Do you want to apply theme? [y/n]:"
    read -r CONFIRMATION

    if [[ $CONFIRMATION == "Y" ]] || [[ $CONFIRMATION == "y" ]]; then
        lookandfeeltool -a "$GLOBALTHEMENAME"
        clear
        echo "The cursors will fully apply once you log out"

        # Some legacy apps still look in ~/.icons
        echo "You may want to run the following in your terminal if you notice any inconsistencies for the cursor theme"
        echo "ln -s ~/.local/share/icons/ ~/.icons"
    else
        echo "You can apply theme at any time using system settings"
        sleep 0.5
    fi
else echo "Exiting.." && exit
fi
