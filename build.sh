#!/bin/bash

rm ./dist/*
sed -e s/--accent/$ACCENTCOLOR/g ./base/base.colors >> ./dist/base.colors
./installer/color-build.sh -o ./dist -s ./dist/base.colors