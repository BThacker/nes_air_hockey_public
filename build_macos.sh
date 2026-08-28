#!/bin/bash
rm -f air_hockey_rev1_1.nes
wine ./nesfab/nesfab_legal.exe air_hockey.cfg

# Check if build was successful
if [ -f "air_hockey_rev1_1.nes" ]; then
    echo "Build successful! Launching Mesen emulator..."
    open -a "Mesen" --args /Users/bthacker/Documents/dev/nes/nes_air_hockey_public/air_hockey_rev1_1.nes
else
    echo "Build failed - air_hockey_rev1_1.nes not found"
    exit 1
fi
