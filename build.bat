del air_hockey.nes 2>nul
"./nesfab-master/nesfab_legal.exe" air_hockey.cfg
if exist air_hockey.nes (
    echo Launching Mesen with air_hockey.nes...
    "C:\Users\BThac\OneDrive\Desktop\mesen.exe" "%~dp0air_hockey.nes"
) else (
    echo Build failed - air_hockey.nes not found
    exit /b 1
)