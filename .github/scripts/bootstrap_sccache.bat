:: For now, sccache is considered as already installed (script is not in use)

@echo off

:: set DEPENDENCIES_DIR=C:\Users\spahontu\env\dependencies
:: set DOWNLOADS_DIR=C:\Users\spahontu\env\downloads

:: Pre check for downloads and dependencies folders
if not exist "%DOWNLOADS_DIR%" mkdir "%DOWNLOADS_DIR%"
if not exist "%DEPENDENCIES_DIR%" mkdir "%DEPENDENCIES_DIR%"

set DOWNLOAD_URL="https://github.com/mozilla/sccache/releases/download/v0.8.1/sccache-v0.8.1-x86_64-pc-windows-msvc.zip"
set TARGET_DIR=sccache
set TARGET_FILE=sccache.exe

:: Check if the file already exists in the destination directory
:: TODO: smarter check mechanism can be used (e.g. call with error level)
if not exist "%DEPENDENCIES_DIR%\%TARGET_DIR%\%TARGET_FILE%" (
    echo Downloading sccache.zip...
    curl -L -o "%DOWNLOADS_DIR%\sccache.zip" %DOWNLOAD_URL%

    echo Extracting sccache.zip...
    tar xf "%DOWNLOADS_DIR%\sccache.zip" -C %DEPENDENCIES_DIR%
    cd %DEPENDENCIES_DIR%
    ren sccache-v0.8.1-x86_64-pc-windows-msvc sccache
    cd ..

    echo Successfully installed: sccache
) else (
    echo Skipped download and install: sccache
)

echo "%DEPENDENCIES_DIR%\%TARGET_DIR%" >> %GITHUB_PATH%
echo SCCACHE_CACHE_SIZE=30G >> %GITHUB_ENV%

echo Dependency sccache installation is finished.

