@echo off
echo Downloading numpy and Scipy wheels for Windows ARM64...

:: Pre check for downloads and dependencies folders
if not exist "%DOWNLOADS_DIR%" mkdir "%DOWNLOADS_DIR%"
if not exist "%DEPENDENCIES_DIR%" mkdir "%DEPENDENCIES_DIR%"

:: Detect Python version
for /f "tokens=2 delims= " %%i in ('python -V 2^>^&1') do set PYTHON_VERSION=%%i

:: Extract the major and minor version numbers
for /f "tokens=1-2 delims=." %%i in ("%PYTHON_VERSION%") do (
    set PYTHON_MAJOR=%%i
    set PYTHON_MINOR=%%j
)

echo Detected Python version: %PYTHON_MAJOR%.%PYTHON_MINOR%

:: Determine the download URL and file names based on the Python version
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

:: Check if the extraction directory already exists
if not exist "%DEPENDENCIES_DIR%\%EXTRACT_DIR%" (
    echo Downloading ZIP file from %DOWNLOAD_URL%...
    curl -L -o "%ZIP_FILE%" %DOWNLOAD_URL%

    :: Check if download was successful
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

    echo Successfully extracted wheels: %EXTRACT_DIR%

    :: Move to PyTorch build folder
    cd %PYTORCH_SOURCES_DIR%
    :: Create virtual environment
    python -m venv venv
    echo * > venv\.gitignore
    call .\venv\Scripts\activate

    :: Move back to wheels directory and install numpy and scipy
    cd "%DEPENDENCIES_DIR%\%EXTRACT_DIR%"

    if "%PYTHON_MAJOR%.%PYTHON_MINOR%"=="3.11" (
        pip install numpy-1.26.2-cp311-cp311-win_arm64.whl
        pip install SciPy-1.11.4-cp311-cp311-win_arm64.whl
    ) else (
        pip install numpy-2.0.0-cp312-cp312-win_arm64.whl
        pip install scipy-1.13.1-cp312-cp312-win_arm64.whl
    )

    echo Dependency installation is finished.
) else (
    echo Skipped download and install: %EXTRACT_DIR%
)
