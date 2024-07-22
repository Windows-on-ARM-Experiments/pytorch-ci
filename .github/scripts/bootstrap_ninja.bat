@echo off
echo Dependency ninja installation is started.

:: set DEPENDENCIES_DIR=C:\Users\spahontu\env\dependencies
:: set DOWNLOADS_DIR=C:\Users\spahontu\env\downloads

:: Pre check for downloads and dependencies folders
if not exist "%DOWNLOADS_DIR%" mkdir "%DOWNLOADS_DIR%"
if not exist "%DEPENDENCIES_DIR%" mkdir "%DEPENDENCIES_DIR%"

set DOWNLOAD_URL="https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-win.zip"
set TARGET_DIR=ninja
set TARGET_FILE=ninja.exe

:: Check if the file already exists in the destination directory
:: TODO: smarter check mechanism can be used (e.g. call with error level)
if not exist "%DEPENDENCIES_DIR%\%TARGET_DIR%\%TARGET_FILE%" (
    echo Downloading ninja.zip...
    curl -L -o "%DOWNLOADS_DIR%\ninja.zip" %DOWNLOAD_URL%

    echo Extracting ninja.zip...
    mkdir "%DEPENDENCIES_DIR%\%TARGET_DIR%"
    tar xf "%DOWNLOADS_DIR%\ninja.zip" -C "%DEPENDENCIES_DIR%\%TARGET_DIR%"
    echo Successfully installed: ninja
) else (
    echo Skipped download and install: ninja
)

echo "%DEPENDENCIES_DIR%\%TARGET_DIR%" >> %GITHUB_PATH%

echo Dependency ninja installation is finished

ninja --version

