#!/usr/bin/env bash

set -ea pipefail

check_command_exists() {
  command_name="${*}"

  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Error: Dependency '$command_name' is not met."
    echo "Exiting.."
    exit 1
  fi
}

check_command_exists "whiskers"
check_command_exists "tar"

build_template() {
  template="$1"
  overrides="$2"
  empty="{}"
  overrides="${overrides:-$empty}"
  echo "Building $template"
  whiskers $template --overrides "${overrides}"
  echo "Done"
  echo
}

build_aurorae_theme() {
  flavor="$1"
  accent="$2"
  style="$3"

  dist="./dist/Catppuccin-$flavor-$accent"

  cp -r ./Resources/Aurorae/"Catppuccin$flavor"-"$style" "$dist"

  if [ "$flavor" == "Latte" ]; then
    cp ./Resources/Aurorae/Common/CatppuccinLatte-"$style"rc "$dist"/Catppuccin"$flavor"-"$style"rc
  else
    cp ./Resources/Aurorae/Common/Catppuccin-"$style"rc "$dist"/Catppuccin"$flavor"-"$style"rc
  fi

  case "$style" in
    Modern)
      case "$flavor" in
        Mocha)     storeCode="2135229" ;;
        Macchiato) storeCode="2135227" ;;
        Frappe)    storeCode="2135225" ;;
        Latte)     storeCode="2135223" ;;
      esac
      ;;
      Classic)
        case "$FLAVOUR" in
          Mocha)     storeCode="2135228" ;;
          Macchiato) storeCode="2135226" ;;
          Frappe)    storeCode="2135224" ;;
          Latte)     storeCode="2135222" ;;
        esac
        ;;
      *) echo "Not a valid Window decoration" ;;
  esac

  build_template templates/look-and-feel/defaults.tera 
  build_template templates/look-and-feel/metadata.json.tera "{ \"storeCode\": \"$storeCode\" }"
  build_template templates/look-and-feel/metadata.desktop.tera "{ \"storeCode\": \"$storeCode\" }"
}

build_splash_screen() {
  flavor="$1"
  accent="$2"

  dist="./dist/Catppuccin-$flavor-$accent/Splash"
  mkdir -p "$dist"/contents/previews
  mkdir -p "$dist"/contents/splash/images

  # Add CTP Logo
  if [ "$flavour" == "latte" ]; then
      cp ./Resources/splash-screen/contents/splash/images/Latte_Logo.png "$dist"/contents/splash/images/Logo.png
  else
      cp ./Resources/splash-screen/contents/splash/images/Logo.png "$dist"/contents/splash/images/Logo.png
  fi

  cp ./Resources/splash-previews/"$flavor".png "$dist"/contents/previews/splash.png
}

render_templates() {
  build_template templates/palette.tera 

  build_template templates/splash-screen/busywidget.tera 
  build_template templates/splash-screen/splash-qml.tera 
}

render_templates

flavors="Mocha Frappe Macchiato Latte"
accents="Rosewater Flamingo Pink Mauve Red Maroon Peach Yellow Green Teal Sky Sapphire Blue Lavender"
for flavor in $flavors;
do
  for accent in $accents;
  do
    build_aurorae_theme "$flavor" "$accent" "Modern"
    build_aurorae_theme "$flavor" "$accent" "Classic"
    build_splash_screen "$flavor" "$accent"

    cp -r ./Resources/LookAndFeel/Catppuccin-"$flavor"-Global/* ./dist/Catppuccin-"$flavor"-"$accent"
  done
done