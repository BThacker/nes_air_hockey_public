
#!/bin/zsh
# Use MESEN_PATH environment variable for your ROM path

rm -rf air_hockey.nes
wine ./nesfab-master/nesfab_legal.exe air_hockey.cfg

# Check if build was successful
if [[ -f "air_hockey.nes" ]]; then
    echo "Build successful! Launching Mesen emulator..."
    echo "Using ROM path: $MESEN_PATH"
    open -a "Mesen" --args "$MESEN_PATH"
else
    echo "Build failed - air_hockey.nes not found"
    exit 1
fi