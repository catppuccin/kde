#!/bin/bash

mkdir -p ~/.local/share/color-schemes

echo -e "Choose flavor out of \nMocha, Macchiato, Frappe, Latte"
read f
echo -e "Choose accent! Examples: \nrosewater, red, green etc..."
read a


if [ $f == "frappe" ] then # Frappe
    echo "Test";
    cd frappe
    cp CatppuccinFrappe-$a.colors ~/.local/share/color-schemes;
    cp Catppuccin-Frappe/contents/defaults default-backup;
    echo "ColorScheme=Catppuccin-Frappe-$a" >> Catppuccin-Frappe/contents/defaults;
    tar -cvz Catppuccin-Frappe -f $f-$a.tar.gz;
    rm Catppuccin-Frappe/contents/defaults
    cp default-backup Catppuccin-Frappe/contents/defaults;
    rm default-backup;

elif [ $f == "mocha" ] then
    echo "Test";
    cd mocha
    cp CatppuccinMocha-$a.colors ~/.local/share/color-schemes;
    cp Catppuccin-Mocha/contents/defaults default-backup;
    echo "ColorScheme=Catppuccin-Mocha-$a" >> Catppuccin-Mocha/contents/defaults;
    tar -cvz Catppuccin-Mocha -f $f-$a.tar.gz;
    rm Catppuccin-Mocha/contents/defaults
    cp default-backup Catppuccin-Mocha/contents/defaults;
    rm default-backup;

elif [ $f == "macchiato" ] then
    cd macchiato
    cp CatppuccinMacchiato-$a.colors ~/.local/share/color-schemes;
    cp Catppuccin-Macchiato/contents/defaults default-backup;
    echo "ColorScheme=Catppuccin-Macchiato-$a" >> Catppuccin-Macchiato/contents/defaults;
    tar -cvz Catppuccin-Mocha -f $f-$a.tar.gz;
    rm Catppuccin-Macchiato/contents/defaults
    cp default-backup Catppuccin-Macchiato/contents/defaults;
    rm default-backup;

elif [ $f == "latte" ] then
    echo "Test";
    cd latte
    cp CatppuccinLatte-$a.colors ~/.local/share/color-schemes;
    cp Catppuccin-Latte/contents/defaults default-backup;
    echo "ColorScheme=Catppuccin-Latte-$a" >> Catppuccin-Latte/contents/defaults;
    tar -cvz Catppuccin-Latte -f $f-$a.tar.gz;
    rm Catppuccin-Latte/contents/defaults
    cp default-backup Catppuccin-Latte/contents/defaults;
    rm default-backup;
else echo "Not a valid flavour name"
fi

#tar -cvz Frappe/ -f frappe.tar.gz
