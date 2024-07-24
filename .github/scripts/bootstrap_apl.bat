:: For now, APL is considered as already installed (script is not in use)

@echo off

echo Dependency APL installation is started.
:: Pre check for downloads and dependencies folders
if not exist "%DOWNLOADS_DIR%" mkdir "%DOWNLOADS_DIR%"
if not exist "%DEPENDENCIES_DIR%" mkdir "%DEPENDENCIES_DIR%"

set DOWNLOAD_URL="https://developer.arm.com/-/media/Files/downloads/hpc/arm-performance-libraries/24-04/windows/arm-performance-libraries_24.04_Windows.msi?rev=2b30cf856f7d4e6b968ce7f3698c1088&revision=2b30cf85-6f7d-4e6b-968c-e7f3698c1088"
set TARGET_DIR=apl\armpl_24.04\bin
set TARGET_FILE=armpl-info.exe

:: Check if the file already exists in the destination directory
:: TODO: smarter check mechanism can be used (e.g. call with error level)
if not exist "%DEPENDENCIES_DIR%\%TARGET_DIR%\%TARGET_FILE%" (
    echo Downloading arm-performance-libraries_24.04_Windows.msi...
    curl -L -o "%DOWNLOADS_DIR%" %DOWNLOAD_URL%

    echo Installing APL 24.04...
    msiexec /i "%DOWNLOADS_DIR%\arm-performance-libraries_24.04_Windows.msi" /qn /norestart ACCEPT_EULA=1 INSTALLFOLDER="%DEPENDENCIES_DIR%\apl"

    echo Successfully installed: APL
) else (
    echo Skipped download and install: APL
)

echo "%DEPENDENCIES_DIR%\%TARGET_DIR%" >> %GITHUB_PATH%
echo ARMPL_DIR=%INSTALL_DIR%\armpl_24.04 >> %GITHUB_ENV%

echo Dependency APL installation is finished.