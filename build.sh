#!/bin/bash
sed -e s/--accentColor/$ACCENTCOLOR/g -e s/--flavour/$FLAVOURNAME/g -e s/--accentName/$ACCENTNAME/g ./Resources/base.colors >> ./dist/base.colors
sed -e s/--accentName/$ACCENTNAME/g -e s/--flavour/$FLAVOURNAME/g ./Resources/metadata.desktop >> ./dist/Catppuccin-$FLAVOURNAME-$ACCENTNAME/metadata.desktop
sed -e s/--accentName/$ACCENTNAME/g -e s/--flavour/$FLAVOURNAME/g ./Resources/defaults >> ./dist/Catppuccin-$FLAVOURNAME-$ACCENTNAME/contents/defaults
./Installer/color-build.sh -o ./dist -s ./dist/base.colors
