#!/usr/bin/env bash

COLORDIR=~/.local/share/color-schemes
AURORAEDIR=~/.local/share/aurorae/themes
LOOKANDFEELDIR=~/.local/share/plasma/look-and-feel
DESKTOPTHEMEDIR=~/.local/share/plasma/desktoptheme

echo "Creating theme directories.."
mkdir -p $COLORDIR
mkdir -p $AURORAEDIR
mkdir -p $LOOKANDFEELDIR
mkdir -p $DESKTOPTHEMEDIR
mkdir ./dist

clear
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
# Sets accent based on the pallet selected (Best to fold this in your respective editor)
if [[ $ACCENT == "1" ]]; then

    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#f5e0dc
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#f4dbd6
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#f2d5cf
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#dc8a78
    fi
    echo "Accent Rosewater(1) was selected!"
    ACCENTNAME="Rosewater"
elif [[ $ACCENT == "2" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#f2cdcd
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#f0c6c6
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#eebebe
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#dd7878
    fi
    echo "Accent Flamingo(2) was selected!"
    ACCENTNAME="Flamingo"
elif [[ $ACCENT == "3" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#f5c2e7
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#f5bde6
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#f4b8e4
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#ea76cb
    fi
    echo "Accent Pink(3) was selected!"
    ACCENTNAME="Pink"
elif [[ $ACCENT == "4" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#cba6f7
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#c6a0f6
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#ca9ee6
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#8839ef
    fi
    echo "Accent Mauve(4) was selected!"
    ACCENTNAME="Mauve"
elif [[ $ACCENT == "5" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#f38ba8
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#ed8796
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#e78284
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#d20f39
    fi
    echo "Accent Red(5) was selected!"
    ACCENTNAME="Red"
elif [[ $ACCENT == "6" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#eba0ac
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#ee99a0
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#ea999c
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#e64553
    fi
    echo "Accent Maroon(6) was selected!"
    ACCENTNAME="Maroon"
elif [[ $ACCENT == "7" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#fab387
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#f5a97f
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#ef9f76
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#fe640b
    fi
    echo "Accent Peach(7) was selected!"
    ACCENTNAME="Peach"
elif [[ $ACCENT == "8" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#f9e2af
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#eed49f
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#e5c890
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#df8e1d
    fi
    echo "Accent Yellow(8) was selected!"
    ACCENTNAME="Yellow"
elif [[ $ACCENT == "9" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#a6e3a1
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#a6da95
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#a6d189
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#40a02b
    fi
    echo "Accent Green(9) was selected!"
    ACCENTNAME="Green"
elif [[ $ACCENT == "10" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#94e2d5
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#8bd5ca
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#81c8be
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#179299
    fi
    echo "Accent Teal(10) was selected!"
    ACCENTNAME="Teal"
elif [[ $ACCENT == "11" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#89dceb
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#91d7e3
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#99d1db
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#04a5e5
    fi
    echo "Accent Sky(11) was selected!"
    ACCENTNAME="Sky"
elif [[ $ACCENT == "12" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#74c7ec
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#7dc4e4
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#85c1dc
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#209fb5
    fi
    echo "Accent Sapphire(12) was selected!"
    ACCENTNAME="Sapphire"
elif [[ $ACCENT == "13" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#89b4fa
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#8aadf4
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#8caaee
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#1e66f5
    fi
    echo "Accent Blue(13) was selected!"
    ACCENTNAME="Blue"
elif [[ $ACCENT == "14" ]]; then
    if [[ $FLAVOUR == "1" ]]; then
        ACCENTCOLOR=#b4befe
    elif [[ $FLAVOUR == "2" ]]; then
        ACCENTCOLOR=#b7bdf8
    elif [[ $FLAVOUR == "3" ]]; then
        ACCENTCOLOR=#babbf1
    elif [[ $FLAVOUR == "4" ]]; then
        ACCENTCOLOR=#7287fd
    fi
    echo "Accent Lavender(14) was selected!"
    ACCENTNAME="Lavender"
else echo "Not a valid accent" && exit
fi

echo "Choose window decoration style -
 1. Modern (Mixed)
 2. Classic (MacOS like)
"
read -r WINDECSTYLE
clear

if [[ $WINDECSTYLE == "1" ]]; then
    WINDECSTYLENAME=Modern
    WINDECSTYLECODE=__aurorae__svg__Catppuccin"$FLAVOURNAME"-Modern
    echo "Hey! thanks for picking 'Modern', this one has a few rules or else it might break
 1: Use 3 icons on the right, With the 'Close' Button on the Far-Right
 2: If you would like the pin on all desktops button, You need to place it on the left."
    echo "We apologize if you wanted a different configuration :("
    sleep 2
elif [[ $WINDECSTYLE == "2" ]]; then
    WINDECSTYLENAME=Classic
    WINDECSTYLECODE=__aurorae__svg__Catppuccin"$FLAVOURNAME"-Classic
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

function AuroraeInstall {
    if [[ $WINDECSTYLE == "1" ]]; then
        cp ./Resources/Aurorae/Catppuccin"$FLAVOURNAME"-Modern $AURORAEDIR -r
        if [[ $FLAVOUR = "4" ]]; then
            cp ./Resources/Aurorae/Common/CatppuccinLatte-Modernrc $AURORAEDIR/CatppuccinLatte-Modern/CatppuccinLatte-Modernrc
        else
            cp ./Resources/Aurorae/Common/Catppuccin-Modernrc $AURORAEDIR/Catppuccin"$FLAVOURNAME"-Modern/Catppuccin"$FLAVOURNAME"-Modernrc
        fi
    elif [[ $WINDECSTYLE == "2" ]]; then
        cp ./Resources/Aurorae/Catppuccin"$FLAVOURNAME"-Classic $AURORAEDIR -r
        if [[ $FLAVOUR = "4" ]]; then
            cp ./Resources/Aurorae/Common/CatppuccinLatte-Classicrc $AURORAEDIR/CatppuccinLatte-Classic/CatppuccinLatte-Classicrc
        else
            cp ./Resources/Aurorae/Common/Catppuccin-Classicrc $AURORAEDIR/Catppuccin"$FLAVOURNAME"-Classic/Catppuccin"$FLAVOURNAME"-Classicrc
        fi
    fi
}

function BuildColorscheme {
    # Add Metadata & Replace Accent in colors file
    sed -e s/--accentColor/"$ACCENTCOLOR"/g -e s/--flavour/"$FLAVOURNAME"/g -e s/--accentName/"$ACCENTNAME"/g ./Resources/Base.colors > ./dist/base.colors

    # Hydrate Metadata with Pallet + Accent Info
    sed -e s/--accentName/"$ACCENTNAME"/g -e s/--flavour/"$FLAVOURNAME"/g ./Resources/LookAndFeel/metadata.desktop > ./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"/metadata.desktop

    # Modify 'defaults' to set the correct Aurorae Theme
    sed -e s/--accentName/"$ACCENTNAME"/g -e s/--flavour/"$FLAVOURNAME"/g -e s/--aurorae/"$WINDECSTYLECODE"/g ./Resources/LookAndFeel/defaults > ./dist/Catppuccin-"$FLAVOURNAME"-"$ACCENTNAME"/contents/defaults

    # Hydrate Dummy colors according to Pallet
    FLAVOURNAME=$FLAVOURNAME ./Installer/color-build.sh -o ./dist/Catppuccin$FLAVOURNAME$ACCENTNAME.colors -s ./dist/base.colors
}

function BuildSplashScreen {
    # Hydrate Dummy colors according to Pallet
    FLAVOURNAME="$FLAVOURNAME" ./Installer/color-build.sh -s ./Resources/Splash/images/busywidget.svg -o ./dist/"$GLOBALTHEMENAME"/contents/splash/images/_busywidget.svg

    # Replace Accent in Loader SVG
    sed ./dist/"$GLOBALTHEMENAME"/contents/splash/images/_busywidget.svg -e s/REPLACE--ACCENT/"$ACCENTCOLOR"/g > ./dist/"$GLOBALTHEMENAME"/contents/splash/images/busywidget.svg

    # Cleanup temporary file
    rm ./dist/"$GLOBALTHEMENAME"/contents/splash/images/_busywidget.svg

    # Hydrate Dummy colors according to Pallet (QML file)
    FLAVOURNAME="$FLAVOURNAME" ./Installer/color-build.sh -s ./Resources/Splash/Splash.qml -o ./dist/"$GLOBALTHEMENAME"/contents/splash/Splash.qml

    if [[ $FLAVOUR == "4" ]]; then
        cp ./Resources/Splash/images/Latte_Logo.png ./dist/"$GLOBALTHEMENAME"/contents/splash/images/Logo.png
    else
        cp ./Resources/Splash/images/Logo.png ./dist/"$GLOBALTHEMENAME"/contents/splash/images/Logo.png
    fi
}

echo ""
echo "Install $FLAVOURNAME $ACCENTNAME? with the $WINDECSTYLENAME window Decorations? [Y/n]:"
read -r CONFIRMATION
clear

if [[ $CONFIRMATION == "Y" ]] || [[ $CONFIRMATION == "y" ]]; then

    # Prepare Global Theme Folder
    GLOBALTHEMENAME="Catppuccin-$FLAVOURNAME-$ACCENTNAME"
    cp -r ./Resources/LookAndFeel/Catppuccin-"$FLAVOURNAME"-Global ./dist/"$GLOBALTHEMENAME"
    mkdir -p ./dist/"$GLOBALTHEMENAME"/contents/splash/images
    
    # Build SplashScreen
    echo "Building SplashScreen.."
    BuildSplashScreen

    # Build Colorscheme
    echo "Building Colorscheme.."

    # Generate Color scheme
    BuildColorscheme

    # Install Colorscheme
    echo "Installing Colorscheme.."
    mv ./dist/Catppuccin"$FLAVOURNAME$ACCENTNAME".colors $COLORDIR

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

    echo "Modifying lightly plasma theme.."
    ModifyLightlyPlasma

    echo "Installing aurorae theme.."
    AuroraeInstall

    # Cleanup
    echo "Cleaning up.."
    rm -rf ./dist

    # Apply theme
    echo ""
    echo "Do you want to apply theme? [Y/n]:"
    read -r CONFIRMATION

    if [[ $CONFIRMATION == "Y" ]] || [[ $CONFIRMATION == "y" ]]; then
        lookandfeeltool -a "$GLOBALTHEMENAME"
        clear
    else
        echo "You can apply theme at any time using system settings"
        sleep 0.5
    fi
else echo "Exiting.." && exit
fi
