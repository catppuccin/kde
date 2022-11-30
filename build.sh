#!/usr/bin/env sh

rm -rf ./dist/*
sed -e s/#accent/#cba6f7/g ./base/base.colors >> ./dist/base.colors
./color-build.sh -o ./dist -s ./dist/base.colors