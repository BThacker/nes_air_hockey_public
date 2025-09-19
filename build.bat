del air_hockey.nes 2>nul
"./nesfab-master/nesfab_legal.exe" air_hockey.cfg
if exist air_hockey.nes (
    echo Launching Mesen with air_hockey.nes...
    REM Use MESEN_PATH env var if set, otherwise try to find mesen.exe in PATH
    if defined MESEN_PATH (
        "%MESEN_PATH%" "%~dp0air_hockey.nes"
    ) else (
        where mesen.exe >nul 2>nul
        if %errorlevel%==0 (
            mesen.exe "%~dp0air_hockey.nes"
        ) else (
            echo Mesen not found. Set MESEN_PATH environment variable to your mesen.exe path to auto-launch.
            echo Build succeeded: air_hockey.nes
        )
    )
) else (
    echo Build failed - air_hockey.nes not found
    exit /b 1