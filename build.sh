#!/bin/bash
sed -e s/--accentColor/$ACCENTCOLOR/g -e s/--flavour/$FLAVOURNAME/g -e s/--accentName/$ACCENTNAME/g ./Resources/base.colors >> ./dist/base.colors
./Installer/color-build.sh -o ./dist -s ./dist/base.colors