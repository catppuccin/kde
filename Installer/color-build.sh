#!/bin/sh -eu

# From github.com/skinatro/theme-tool

help() {
    cat <<EOF

Usage: ${0##*/} -o <output> -s <source>
    -o <path> Output directory
    -s <path> Source file
EOF
    exit 1 # Exit script after printing help  
}

while getopts o:s: opt; do
    case "$opt" in
        o) OUT="$OPTARG" ;;
        s) SOURCE="$OPTARG" ;;
        ?) help ;; # Print help in case parameter is non-existent
    esac
done

# Print help in case parameters are empty
if [ -z "$OUT" ] || [ -z "$SOURCE" ]; then
    echo "Some or all of the parameters are empty"
    help
fi

# no arrays due to posix compliancy
if echo "$FLAVOURNAME" | grep -Evq 'Mocha|Macchiato|Frappe|Latte'; then
    clear
    echo "Invalid palette $FLAVOURNAME"
    exit
fi
sed -f Installer/Pallets/"$FLAVOURNAME".sed "$SOURCE" > "$OUT"
