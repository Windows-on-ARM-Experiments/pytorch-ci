echo "this is a test"
@REM @echo off
@REM echo Dependency ninja installation is started.

@REM :: set DEPENDENCIES_DIR=C:\Users\spahontu\env\dependencies
@REM :: set DOWNLOADS_DIR=C:\Users\spahontu\env\downloads

@REM :: Pre check for downloads and dependencies folders
@REM if not exist "%DOWNLOADS_DIR%" mkdir "%DOWNLOADS_DIR%"
@REM if not exist "%DEPENDENCIES_DIR%" mkdir "%DEPENDENCIES_DIR%"

@REM set DOWNLOAD_URL="https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-win.zip"
@REM set TARGET_DIR=ninja
@REM set TARGET_FILE=ninja.exe

@REM :: Check if the file already exists in the destination directory
@REM :: TODO: smarter check mechanism can be used (e.g. call with error level)
@REM if not exist "%DEPENDENCIES_DIR%\%TARGET_DIR%\%TARGET_FILE%" (
@REM     echo Downloading ninja.zip...
@REM     curl -L -o "%DOWNLOADS_DIR%\ninja.zip" %DOWNLOAD_URL%

@REM     echo Extracting ninja.zip...
@REM     mkdir "%DEPENDENCIES_DIR%\%TARGET_DIR%"
@REM     tar xf "%DOWNLOADS_DIR%\ninja.zip" -C "%DEPENDENCIES_DIR%\%TARGET_DIR%"
@REM     echo Successfully installed: ninja
@REM ) else (
@REM     echo Skipped download and install: ninja
@REM )

@REM echo "%DEPENDENCIES_DIR%\%TARGET_DIR%" >> %GITHUB_PATH%

@REM echo Dependency ninja installation is finished

@REM ninja --version

