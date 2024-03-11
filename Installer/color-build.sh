#!/bin/sh

# From github.com/skinatro/theme-tool

help() {
  cat <<EOF

Usage: ${0##*/} -o <output> -s <source> -f <flavour>
    -o <path> Output directory
    -s <path> Source file
    -f <flavour>  Flavour name (Mocha, Macchiato, Frappe, Latte)
EOF
  exit 1 # Exit script after printing help
}

while getopts o:s:f: opt; do
  case "$opt" in
    o) OUT="$OPTARG" ;;
    s) SOURCE="$OPTARG" ;;
    f) FLAVOURNAME="$OPTARG" ;;  # New case for -f
    ?) help ;;
  esac
done

# Print help in case parameters are empty
if [ -z "$OUT" ] || [ -z "$SOURCE" ] || [ -z "$FLAVOURNAME" ]; then
  echo "Some or all of the parameters are empty"
  help
fi

# no arrays due to posix compliancy
if echo "$FLAVOURNAME" | grep -Evq 'Mocha|Macchiato|Frappe|Latte'; then
  clear
  echo "Invalid palette $FLAVOURNAME"
  exit
fi

FLAVOUR_SED="Installer/Pallets/${FLAVOURNAME}.sed"
sed -f "$FLAVOUR_SED" "$SOURCE" > "$OUT"
