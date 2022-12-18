#!/bin/bash

COLORDIR=~/.local/share/color-schemes
AURORAEDIR=~/.local/share/aurorae/themes
LOOKANDFEELDIR=~/.local/share/plasma/look-and-feel

echo "Creating dirs..."

mkdir -p $COLORDIR
mkdir -p $AURORAEDIR
mkdir -p $LOOKANDFEELDIR

echo ""

echo -e "Choose flavor out of -
 1. Mocha 
 2. Macchiato 
 3. Frappe
 4. Latte 
\n (Type the number corresponding to said pallet)
"
read FLAVOUR
clear
if [ $FLAVOUR == 1 ]; then 
    echo "The pallet Mocha(1) was selected";
    FLAVOURNAME="Mocha";
elif [ $FLAVOUR == 2 ]; then
    echo "The pallet Macchiato(2) was selected";
    FLAVOURNAME="Macchiato";
elif [ $FLAVOUR == 3 ]; then
    echo "The pallet Frappe(3) was selected";
    FLAVOURNAME="Frappe";
elif [ $FLAVOUR == 4 ]; then
    echo "The pallet Latte(4) was selected";
    FLAVOURNAME="Latte";
else echo "Not a valid flavour name" && exit;
fi
echo ""

echo -e "Choose an accent -
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
read ACCENT
clear

if [ $ACCENT == 1 ]; then

    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#f5e0dc
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#f4dbd6
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#f2d5cf
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#dc8a78
    fi
    echo "Accent Rosewater(1) was selected!"
    ACCENTNAME="Rosewater"
elif [ $ACCENT == 2 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#f2cdcd
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#f0c6c6
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#eebebe
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#dd7878
    fi
    echo "Accent Flamingo(2) was selected!"
    ACCENTNAME="Flamingo"
elif [ $ACCENT == 3 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#f5c2e7
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#f5bde6
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#f4b8e4
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#ea76cb
    fi
    echo "Accent Pink(3) was selected!"
    ACCENTNAME="Pink"
elif [ $ACCENT == 4 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#cba6f7
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#c6a0f6
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#ca9ee6
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#8839ef
    fi
    echo "Accent Mauve(4) was selected!"
    ACCENTNAME="Mauve"
elif [ $ACCENT == 5 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#f38ba8
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#ed8796
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#e78284
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#d20f39
    fi
    echo "Accent Red(5) was selected!"
    ACCENTNAME="Red"
elif [ $ACCENT == 6 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#eba0ac
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#ee99a0
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#ea999c
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#e64553
    fi
    echo "Accent Maroon(6) was selected!"
    ACCENTNAME="Maroon"
elif [ $ACCENT == 7 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#fab387
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#f5a97f
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#ef9f76
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#fe640b
    fi
    echo "Accent Peach(7) was selected!"
    ACCENTNAME="Peach"
elif [ $ACCENT == 8 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#f9e2af
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#eed49f
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#e5c890
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#df8e1d
    fi
    echo "Accent Yellow(8) was selected!"
    ACCENTNAME="Yellow"
elif [ $ACCENT == 9 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#a6e3a1
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#a6da95
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#a6d189
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#40a02b
    fi
    echo "Accent Green(9) was selected!"
    ACCENTNAME="Green"
elif [ $ACCENT == 10 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#94e2d5
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#8bd5ca
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#81c8be
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#179299
    fi
    echo "Accent Teal(10) was selected!"
    ACCENTNAME="Teal"
elif [ $ACCENT == 11 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#89dceb
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#91d7e3
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#99d1db
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#04a5e5
    fi
    echo "Accent Sky(11) was selected!"
    ACCENTNAME="Sky"
elif [ $ACCENT == 12 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#74c7ec
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#7dc4e4
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#85c1dc
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#209fb5
    fi
    echo "Accent Sapphire(12) was selected!"
    ACCENTNAME="Sapphire"
elif [ $ACCENT == 13 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#89b4fa
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#8aadf4
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#8caaee
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#1e66f5
    fi
    echo "Accent Blue(13) was selected!"
    ACCENTNAME="Blue"
elif [ $ACCENT == 14 ]; then
    if [ $FLAVOUR == 1 ]; then
        ACCENTCOLOR=#b4befe
    elif [ $FLAVOUR == 2 ]; then
        ACCENTCOLOR=#b7bdf8
    elif [ $FLAVOUR == 3 ]; then
        ACCENTCOLOR=#babbf1
    elif [ $FLAVOUR == 4 ]; then
        ACCENTCOLOR=#7287fd
    fi
    echo "Accent Lavender(14) was selected!"
    ACCENTNAME="Lavender"
else echo "Not a valid accent" && exit
fi

# echo $ACCENTCOLOR

echo ""
echo -e "Install $FLAVOURNAME $ACCENTNAME? [Y/n]:"
read CONFIRMATION

if [ $CONFIRMATION = "Y" ]; then
    ACCENTCOLOR=$ACCENTCOLOR FLAVOURNAME=$FLAVOURNAME ACCENTNAME=$ACCENTNAME ./build.sh; #Pass args to build script
    mv ./dist/Catppuccin$FLAVOURNAME.colors $COLORDIR
    plasma-apply-colorscheme Catppuccin$FLAVOURNAME
    
else echo "Exiting.." && exit

fi
