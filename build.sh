#!/usr/bin/env sh

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
  whiskers $template --overrides "${overrides}"
}

build_aurorae_theme() {
  flavor="$1"
  accent="$2"
  style="$3"

  dist="./dist/catppuccin-$flavor-$accent"

  cp -r ./resources/aurorae/"catppuccin-$flavor"-"$style" "$dist"

  if [ "$flavor" == "latte" ]; then
    cp ./resources/aurorae/common/catppuccin-latte-"$style".rc "$dist/catppuccin-$flavor-$style/catppuccin-$flavor-$style"rc
  fi

  case "$style" in
    modern)
      case "$flavor" in
        mocha)     storeCode="2135229" ;;
        macchiato) storeCode="2135227" ;;
        frappe)    storeCode="2135225" ;;
        latte)     storeCode="2135223" ;;
      esac
      ;;
      classic)
        case "$flavor" in
          mocha)     storeCode="2135228" ;;
          macchiato) storeCode="2135226" ;;
          frappe)    storeCode="2135224" ;;
          latte)     storeCode="2135222" ;;
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

  dist="./dist/catppuccin-$flavor-$accent/Splash"
  mkdir -p "$dist"/contents/previews
  mkdir -p "$dist"/contents/splash/images

  # Add CTP Logo
  if [ "$flavour" == "latte" ]; then
      cp ./resources/splash-screen/contents/splash/images/latte-logo.png "$dist"/contents/splash/images/Logo.png
  else
      cp ./resources/splash-screen/contents/splash/images/logo.png "$dist"/contents/splash/images/Logo.png
  fi

  cp ./resources/splash-previews/"$flavor".png "$dist"/contents/previews/splash.png
}

render_templates() {
  build_template templates/palette.tera 

  build_template templates/splash-screen/busywidget.tera 
  build_template templates/splash-screen/splash-qml.tera 
  build_template templates/splash-screen/metadata.json.tera
  build_template templates/splash-screen/metadata.desktop.tera 
}

render_templates

flavors="mocha frappe macchiato latte"
accents="rosewater flamingo pink mauve red maroon peach yellow green teal sky sapphire blue lavender"
for flavor in $flavors;
do
  for accent in $accents;
  do
    echo -n "Building $flavor - $accent..."
    build_aurorae_theme "$flavor" "$accent" "modern"
    build_aurorae_theme "$flavor" "$accent" "classic"
    build_splash_screen "$flavor" "$accent"

    cp -r ./resources/look-and-feel/catppuccin-"$flavor"-global/* "./dist/catppuccin-$flavor-$accent"
    if [ ! ${DEBUG+x} ]; then
      cd dist
      tar -czf "catppuccin-$flavor-$accent.tar.gz" "catppuccin-$flavor-$accent"
      cd ..
    fi
    echo " done"
  done
done

echo "finish"