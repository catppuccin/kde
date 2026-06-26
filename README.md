<h3 align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="100" alt="Logo"/><br/>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
	Catppuccin for <a href="https://www.kde.org/">KDE</a>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
</h3>

<p align="center">
    <a href="https://github.com/catppuccin/kde/stargazers"><img src="https://img.shields.io/github/stars/catppuccin/kde?colorA=363a4f&colorB=b7bdf8&style=for-the-badge"></a>
    <a href="https://github.com/catppuccin/kde/issues"><img src="https://img.shields.io/github/issues/catppuccin/kde?colorA=363a4f&colorB=f5a97f&style=for-the-badge"></a>
    <a href="https://github.com/catppuccin/kde/contributors"><img src="https://img.shields.io/github/contributors/catppuccin/kde?colorA=363a4f&colorB=a6da95&style=for-the-badge"></a>
</p>


<p align="center">
  <img src="./Assets/res.webp"/>
</p>

## Previews

<details>
<summary>🌻 Latte</summary>
<img src="./Resources/LookAndFeel/Catppuccin-Latte-Global/contents/previews/fullscreenpreview.jpg"/>
</details>
<details>
<summary>🪴 Frappé</summary>
<img src="./Resources/LookAndFeel/Catppuccin-Frappe-Global/contents/previews/fullscreenpreview.jpg"/>
</details>
<details>
<summary>🌺 Macchiato</summary>
<img src="./Resources/LookAndFeel/Catppuccin-Macchiato-Global/contents/previews/fullscreenpreview.jpg"/>
</details>
<details>
<summary>🌿 Mocha</summary>
<img src="./Resources/LookAndFeel/Catppuccin-Mocha-Global/contents/previews/fullscreenpreview.jpg"/>
</details>

## Installation

### For KDE Plasma Desktop:
1. `git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde && cd catppuccin-kde`
2. Run the install script using `./install.sh` and follow the instructions.

#### Automated Installation
Install without any prompts by passing the flavour, accent, and window-decoration numbers plus `auto`:

`./install.sh [-q|--quiet] <flavour 1-4> <accent 1-14> <window_decoration 1-2> auto`

Example (Mocha, Blue, Classic):
`./install.sh 1 13 2 auto`

### For Krita:
1. Download the colour-scheme zip file for your preferred flavour from the [release](https://github.com/catppuccin/kde/releases/) tab.
2. Extract the file and move the theme(s) you wish to install into the following folders for your platform:
   Windows: `%appdata%\krita\color-schemes`  
   Linux: `~/.local/share/krita/color-schemes`
3. Open Krita, and you can choose the theme from Settings > Themes.


## Notes
1. If you are using KDE 5.27 or below, you might want to run `git checkout v0.2.5`  before running the install script to avoid running into compatibility issues. Alternatively, the release binaries are available [here](https://github.com/catppuccin/kde/releases/tag/v0.2.5).
2. If you encounter an error similar to 'connection refused' while running the installation script, it may be due to store.kde.org being down or issues with your internet connection.


## 💝 Current Maintainers
- [Sourcastic](https://github.com/Sourcastic)
- [soleynn](https://github.com/soleynn)

## 💖 Past Maintainers
- [Prayag2](https://github.com/Prayag2)


&nbsp;

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>
<p align="center">Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
<p align="center"><a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a></p>
