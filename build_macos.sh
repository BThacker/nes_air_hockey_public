#!/bin/bash

rom_name="air_hockey_rev1_1.nes"
labels_name="air_hockey_rev1_1.mlb"
compiler_args=(air_hockey.cfg)

case "${1:-}" in
    "")
        rm -f "$labels_name"
        ;;
    debug)
        compiler_args+=(--mlb "$labels_name")
        ;;
    *)
        echo "Usage: bash build_macos.sh [debug]"
        exit 2
        ;;
esac

rm -f "$rom_name"
wine ./nesfab/nesfab_legal.exe "${compiler_args[@]}"

if [ ! -f "$rom_name" ]; then
    echo "Build failed - $rom_name not found"
    exit 1
fi

if [ "${1:-}" = "debug" ]; then
    echo "Debug build successful! Mesen labels: $labels_name"
else
    echo "Build successful!"
fi

open -a "Mesen" --args "$PWD/$rom_name"
