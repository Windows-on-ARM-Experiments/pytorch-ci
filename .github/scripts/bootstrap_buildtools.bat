@echo off
setlocal

echo this is a test

@REM echo Dependency MSVC Build Tools installation is started.

@REM REM Define directories
@REM :: set "DEPENDENCIES_DIR=C:\Users\spahontu\env\dependencies"
@REM :: set "DOWNLOADS_DIR=C:\Users\spahontu\env\downloads"

@REM REM Pre-check for downloads and dependencies folders
@REM if not exist "%DOWNLOADS_DIR%" mkdir "%DOWNLOADS_DIR%"
@REM if not exist "%DEPENDENCIES_DIR%" mkdir "%DEPENDENCIES_DIR%"

@REM REM Set download URL for the Visual Studio Installer
@REM set "DOWNLOAD_URL=https://aka.ms/vs/17/release/vs_BuildTools.exe"
@REM set "INSTALLER_FILE=%DOWNLOADS_DIR%\vs_BuildTools.exe"

@REM REM Check if the Visual Studio Installer is already downloaded
@REM if not exist "%INSTALLER_FILE%" (
@REM     echo Downloading Visual Studio Build Tools installer...
@REM     curl -L -o "%INSTALLER_FILE%" %DOWNLOAD_URL%
    
@REM     REM Check if download was successful
@REM     if %errorlevel% neq 0 (
@REM         echo Failed to download the Visual Studio Build Tools installer.
@REM         exit /b 1
@REM     )
@REM ) else (
@REM     echo Skipped download: Visual Studio Build Tools installer already exists.
@REM )

@REM REM Install the MSVC Build Tools with C++ and ARM64/ARM64EC components
@REM echo Installing MSVC Build Tools with C++ and ARM64/ARM64EC components...
@REM "%INSTALLER_FILE%" --quiet --wait --norestart --nocache ^
@REM     --add Microsoft.VisualStudio.Workload.VCTools ^
@REM     --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 ^
@REM     --add Microsoft.VisualStudio.Component.VC.Tools.ARM64EC

@REM REM Check if installation was successful
@REM if %errorlevel% neq 0 (
@REM     echo Failed to install MSVC Build Tools.
@REM     exit /b 1
@REM )

@REM echo Successfully installed MSVC Build Tools with C++ and ARM64/ARM64EC components.
