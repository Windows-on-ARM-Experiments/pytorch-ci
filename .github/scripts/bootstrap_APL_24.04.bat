@echo on
set FILE_NAME=Arm Performance Libraries
set FILE_URL="https://developer.arm.com/-/media/Files/downloads/hpc/arm-performance-libraries/24-04/windows/arm-performance-libraries_24.04_Windows.msi?rev=2b30cf856f7d4e6b968ce7f3698c1088&revision=2b30cf85-6f7d-4e6b-968c-e7f3698c1088"
set INSTALLER_FILE=arm-performance-libraries_24.04_Windows.msi
set DEST_DIR=%JOB_DIR%
set INSTALL_DIR=%DEST_DIR%%FILE_NAME%
 
:: Check if the ZIP file already exists in the destination directory
if not exist "%DEST_DIR%%INSTALLER_FILE%" (
    echo File not found. Downloading...
    curl -L -o "%INSTALLER_FILE%" %FILE_URL%
    echo Installing APL 24.04...
    msiexec /i "%INSTALLER_FILE%" /qn /norestart ACCEPT_EULA=1 INSTALLFOLDER="%INSTALL_DIR%"
    del %INSTALLER_FILE%   
) else (
    echo File already exists. Skipping download and install.
)

ECHO ARMPL_DIR=%INSTALL_DIR%\armpl_24.04 >> %GITHUB_ENV%
echo Done.