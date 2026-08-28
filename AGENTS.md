# NES Air Hockey contributor guide

## Project overview

- This is an NES air hockey game written in NESFab (`.fab` files).
- This runs on original Nintendo Entertainment System hardware. Performance, RAM usage, ROM size, and cycle-efficient code are critical; avoid adding unnecessary work to frame-time code paths.
- The compiler configuration is `air_hockey.cfg`; it produces `air_hockey_rev1A.nes`.
- Game code lives in `src/`. Graphics, layouts, and audio live in `chr/`, `nametables/`, and `audio/`.

## Building

- Windows: run `build.bat`.
- macOS: run `build_macos.sh` with Wine and Mesen installed.
- NESFab version 1.8 is required. Keep the compiler path consistent across `air_hockey.cfg` and build scripts when changing the tool setup.
- The official NESFab documentation and coding guidelines are in `nesfab/source1.8/doc/doc.adoc`.
- Treat generated `.nes` and `.mlb` files as build output; do not commit them.

## Working conventions

- Preserve the current NESFab style and keep gameplay changes narrowly scoped.
- Keep one empty line between top-level declarations, no empty line after section headings or leading comments, and no consecutive blank lines. Run `bash scripts/format_fab.sh --check` after formatting changes; use `--write` only to apply the repository formatter.
- Use boxed uppercase headers only for major module sections. Comments should explain non-obvious intent, timing, hardware constraints, units, invariants, or side effects; avoid comments that merely restate the code.
- Update `README.md` when changing player-facing controls, build requirements, or project setup.
- Do not add NESFab executables, documentation, or examples under `nesfab/` to Git; they are locally supplied dependencies.
- Before handing off code changes, run the relevant build when the required local NESFab toolchain is available. Otherwise, state that it was not run.
