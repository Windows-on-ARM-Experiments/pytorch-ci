@echo off
setlocal

echo Dependency MSVC Build Tools installation is started.

REM Pre-check for downloads and dependencies folders
if not exist "%DOWNLOADS_DIR%" mkdir "%DOWNLOADS_DIR%"
if not exist "%DEPENDENCIES_DIR%" mkdir "%DEPENDENCIES_DIR%"

REM Set download URL for the Visual Studio Installer
set "DOWNLOAD_URL=https://aka.ms/vs/17/release/vs_BuildTools.exe"
set "INSTALLER_FILE=%DOWNLOADS_DIR%\vs_BuildTools.exe"

REM Check if the Visual Studio Installer is already downloaded
if not exist "%INSTALLER_FILE%" (
    echo Downloading Visual Studio Build Tools installer...
    curl -L -o "%INSTALLER_FILE%" %DOWNLOAD_URL%
    
    REM Check if download was successful
    if %errorlevel% neq 0 (
        echo Failed to download the Visual Studio Build Tools installer.
        exit /b 1
    )
) else (
    echo Skipped download: Visual Studio Build Tools installer already exists.
)

REM Install the MSVC Build Tools with C++ and ARM64/ARM64EC components
echo Installing MSVC Build Tools with C++ and ARM64/ARM64EC components...
"%INSTALLER_FILE%" --norestart --nocache --quiet --wait --installPath "%DEPENDENCIES_DIR%" ^
    --add Microsoft.VisualStudio.Workload.VCTools ^
    --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 ^
    --add Microsoft.VisualStudio.Component.VC.Tools.ARM64EC

REM Check if installation was successful
if %errorlevel% neq 0 (
    echo Failed to install MSVC Build Tools.
    exit /b 1
)

echo Successfully installed MSVC Build Tools with C++ and ARM64/ARM64EC components.
