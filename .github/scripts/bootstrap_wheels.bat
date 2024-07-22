@echo off
echo Downloading numpy and Scipy wheels for Windows ARM64...

::set DEPENDENCIES_DIR=C:\Users\spahontu\env\dependencies
:: set DOWNLOADS_DIR=C:\Users\spahontu\env\downloads

:: Pre check for downloads and dependencies folders
if not exist "%DOWNLOADS_DIR%" mkdir "%DOWNLOADS_DIR%"
if not exist "%DEPENDENCIES_DIR%" mkdir "%DEPENDENCIES_DIR%"
REM Detect Python version
for /f "tokens=2 delims= " %%i in ('python -V 2^>^&1') do set PYTHON_VERSION=%%i

REM Extract the major and minor version numbers
for /f "tokens=1-2 delims=." %%i in ("%PYTHON_VERSION%") do (
    set PYTHON_MAJOR=%%i
    set PYTHON_MINOR=%%j
)

echo Detected Python version: %PYTHON_MAJOR%.%PYTHON_MINOR%

REM Determine the download URL and file names based on the Python version
if "%PYTHON_MAJOR%.%PYTHON_MINOR%"=="3.11" (
    set "DOWNLOAD_URL=https://github.com/cgohlke/win_arm64-wheels/releases/download/v2023.12.6/2023.12.6-experimental-cp311-win_arm64.whl.zip"
    set "ZIP_FILE=%DOWNLOADS_DIR%\2023.12.6-experimental-cp311-win_arm64.whl.zip"
    set "EXTRACT_DIR=2023.12.6-experimental-cp311-win_arm64.whl"
) else if "%PYTHON_MAJOR%.%PYTHON_MINOR%"=="3.12" (
    set "DOWNLOAD_URL=https://github.com/cgohlke/win_arm64-wheels/releases/download/v2024.6.15/2024.6.15-experimental-cp312-win_arm64.whl.zip"
    set "ZIP_FILE=%DOWNLOADS_DIR%\2024.6.15-experimental-cp312-win_arm64.whl.zip"
    set "EXTRACT_DIR=2024.6.15-experimental-cp312-win_arm64.whl"
) else (
    echo Unsupported Python version: %PYTHON_MAJOR%.%PYTHON_MINOR%
    exit /b 1
)

REM Check if the extraction directory already exists
if not exist "%DEPENDENCIES_DIR%\%EXTRACT_DIR%" (
    echo Downloading ZIP file from %DOWNLOAD_URL%...
    curl -L -o "%ZIP_FILE%" %DOWNLOAD_URL%

    REM Check if download was successful
    if %errorlevel% neq 0 (
        echo Failed to download the ZIP file.
        exit /b 1
    )

    echo Extracting %ZIP_FILE%...
    tar -xf "%ZIP_FILE%" -C "%DEPENDENCIES_DIR%"
    if %errorlevel% neq 0 (
        echo Failed to extract the file.
        exit /b 1
    )

    echo Successfully installed: %EXTRACT_DIR%
) else (
    echo Skipped download and install: %EXTRACT_DIR%
)

cd "%DEPENDENCIES_DIR%\%EXTRACT_DIR%"
dir
@REM pip install numpy
@REM pip install scipy

echo Dependency installation is finished.

if exist "%DOWNLOADS_DIR%" (
    echo Deleting downloads directory...
    rd /s /q "%DOWNLOADS_DIR%"
)
if exist "%DEPENDENCIES_DIR%" (
    echo Deleting dependencies directory...
    rd /s /q "%DEPENDENCIES_DIR%"
)

