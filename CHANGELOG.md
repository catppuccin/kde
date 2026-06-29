# Changelog

all notable changes to this project are documented here.

the format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.1] - 2026-06-29

### Fixed

- hover fill no longer forces unreadable light text on the accent (#136)

## [0.3.0] - 2026-06-26

### Added

- install cursors offline from a local path with `-c`/`--local-cursor` (#125)
- `-q`/`--quiet` flag to suppress default logging

## [0.2.7] - 2026-06-20

### Added

- non-interactive `auto` mode: `./install.sh <flavour> <accent> <windowdec> auto` (#68)

### Changed

- cursors bumped to scalable v2.0.0 (#92)
- accent color on window-decoration hover (#97)
- theme-apply confirmation prompt (#113)

### Fixed

- batch of installer, palette, template, and splash bugs (#109)
- global theme not showing up in KDE settings on plasma 6 (#111)
- borderless windows now actually apply on install (#120)
- restore thin/no window borders (#118)
- corners bleeding blur past the rounded edge (#122)
- consistent padding for the classic window buttons (#103)
- overflow in the modern aurorae theme (#61)
- selection-bar text readable on every accent (#119)
- selection text stays readable when its panel is unfocused (#121)

## [0.2.6] - 2024-03-15

### Changed

- ported the whole theme to KDE 6 / plasma 6, install script included (#52)

### Removed

- the lightly plasma style (panels and widgets), now using default breeze

## [0.2.5] - 2024-03-14

### Changed

- install script rewritten to be POSIX-compliant; PRs must pass shellcheck from here on
- last release to support plasma 5 (0.2.6+ is plasma 6 only)

## [0.2.4] - 2023-04-09

### Added

- install and apply Catppuccin cursors from the cursors port (dark + your chosen accent)
- prefill options from args, e.g. `./install.sh 2 4 1`

### Fixed

- Qt6 apps get themed properly again (#37)

## [0.2.3] - 2023-02-23

### Added

- Krita color-scheme install instructions in the readme

### Changed

- modern aurorae theme is smaller by default
- releases now bundle all 56 color schemes alongside the aurorae themes

### Fixed

- centred the shadows in the splash screen

## [0.2.2] - 2023-02-05

### Added

- modern aurorae theme and a splash screen (#30)

### Changed

- the original aurorae theme is now named "classic"

### Fixed

- broken link to the lightly-plasma repo (#28)

## [0.2.1] - 2023-01-20

### Added

- aurorae theme (#4), plasma theme, and an install script that makes accent selection easy (#17)

[Unreleased]: https://github.com/catppuccin/kde/compare/v0.3.1...HEAD
[0.3.1]: https://github.com/catppuccin/kde/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/catppuccin/kde/compare/v0.2.7...v0.3.0
[0.2.7]: https://github.com/catppuccin/kde/compare/v0.2.6...v0.2.7
[0.2.6]: https://github.com/catppuccin/kde/compare/v0.2.5...v0.2.6
[0.2.5]: https://github.com/catppuccin/kde/compare/v0.2.4...v0.2.5
[0.2.4]: https://github.com/catppuccin/kde/compare/v0.2.3...v0.2.4
[0.2.3]: https://github.com/catppuccin/kde/compare/v0.2.2...v0.2.3
[0.2.2]: https://github.com/catppuccin/kde/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/catppuccin/kde/releases/tag/v0.2.1
