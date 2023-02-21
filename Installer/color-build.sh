#!/usr/bin/env bash

# From github.com/skinatro/theme-tool/

####################
#Help and Arguments#
####################
help()
{
    echo ""
    echo "Usage: $0 -o Output -s Source"
    printf "\n-o Output Directory"
    printf "\n-s Source file"
    exit 1 # Exit script after printing help  
}

while getopts "o:s:" opt
do
   case "$opt" in
      o ) OUT="$OPTARG" ;;
      s ) SOURCE="$OPTARG" ;;
      ? ) help ;; # Print help in case parameter is non-existent
   esac
done

# Print help in case parameters are empty
if [ -z "$OUT" ] || [ -z "$SOURCE" ]
then
   echo "Some or all of the parameters are empty";
    help
fi

##############
#Script begin#
##############

#function defined to build the file
build(){
#combine everything to get the output path
SCRIPT="Installer/Pallets/${PALETTE}.sed"

#does the actual sed-fu 
< "$SOURCE" sed -f "$SCRIPT" > "$OUT"

}

#no arrays due to posix compliancy
if [ "$FLAVOURNAME" = "Mocha" ]; then
   PALETTE=Mocha
   build
elif [ "$FLAVOURNAME" = "Macchiato" ]; then
   PALETTE=Macchiato
   build
elif [ "$FLAVOURNAME" = "Frappe" ]; then
   PALETTE=Frappe
   build
elif [ "$FLAVOURNAME" = "Latte" ]; then
   PALETTE=Latte
   build
else clear && echo "Invalid pallet $FLAVOURNAME" && exit
fi
