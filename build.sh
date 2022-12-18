#!/bin/bash

rm -rf ./dist/**
sed -e s/--accentColor/$ACCENTCOLOR/g -e s/--flavour/$FLAVOURNAME/g -e s/--accentName/$ACCENTNAME/g ./base/base.colors >> ./dist/base.colors
./installer/color-build.sh -o ./dist -s ./dist/base.colors