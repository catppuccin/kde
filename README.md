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
  <img src="https://github.com/Prayag2/catppuccin_kde/blob/main/assets/ss.png"/>
</p>

## Installation

1. `mkdir -p ~/.local/share/color-schemes`
2. `git clone https://github.com/catppuccin/kde catppuccin-kde`

### Install all flavors
1. `cd catppuccin-kde`
2. `find . -type f -name "*.colors" -exec cp "{}" ~/.local/share/color-schemes \;`
3. `find . -type f -name "*.tar.gz" -exec kpackagetool5 -i "{}" \;`  
You need a working internet connection for this to work. Make sure system settings is not running.

### Install one flavor
1. `cd catppuccin-kde/<your chosen flavor>`
2. `cp Catppuccin*.colors ~/.local/share/color-schemes/`
3. `kpackagetool5 -i Catppuccin-*.tar.gz`  
You need a working internet connection for this to work. Make sure system settings is not running.
4. `lookandfeeltool -a Catppuccin-<flavor>` or alternatively open system settings and choose the global theme

## Update

1. `cd catppuccin-kde`
2. `git pull`
3. Run the installation commands again, replacing `kpackagetool5 -i` with `kpackagetool5 -u`

  
	 Notes:
> 1. To get a material-like look, install [Lightly application style](https://github.com/Luwx/Lightly) and select it from System Settings > Appearance >  Application Style > Lightly.
> 
> 2. If you do not like the new icon for the application launcher set by the lightly plasma theme, simply delete `~/.local/share/plasma/desktoptheme> > /lightly-plasma-git/icons`. This will make it switch to the default.

## 💝 Thanks to

- [Prayag2](https://github.com/Prayag2)
- [Sourcastic](https://github.com/Sourcastic)

&nbsp;

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>
<p align="center">Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
<p align="center"><a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a></p>
