# Changelog

All notable changes to Air Hockey - NES are documented here.

## REV 1A

### Added

- Easy, Normal, and Hard one-player AI difficulty selection.
- Configurable first-to-3, first-to-5, or first-to-7 match length.
- A sprite-based flashing `DEMO` indicator for attract mode.
- A `REV1A` identifier on the title screen.
- macOS debug builds with Mesen label output.

### Changed

- Split physics and menu responsibilities into dedicated source modules.
- Improved source formatting, comments, and project documentation.
- Attract mode now cycles through the Arcade, Space, and Retro themes.
- Goal scoring now resolves within the physics tick that crosses a goal line.

### Fixed

- Corrected attract-mode drone decisions, collision counting, and winner cases.
- Corrected the one-player color-selection AI marker.
- Restored all six possible AI colors in one-player matches.
- Corrected goal-mouth post collisions and contained pucks displaced by mallet separation.
- Prevented AI aim prediction from wrapping outside the rink.
- Reset trapped-puck tracking at the start of each round.
- Kept score sprites visible during goal replays.
- Cleared OAM explicitly after a hardware reset to prevent stale sprites.
- Prioritized the attract-mode `DEMO` sprite over Space-theme stars.
