@echo on
:: start sccache server and reset sccache stats
sccache --zero-stats

:: environment variables
if "%ENABLE_APL%"=="1" (
  set BLAS=APL
  set PATH=%DEPENDENCY_APL_DIR%;%PATH%
) else if "%ENABLE_OPENBLAS%"=="1" (
  set BLAS=OpenBLAS
  set OpenBLAS_HOME=%DEPENDENCY_OPENBLAS_DIR%\install
)
set REL_WITH_DEB_INFO=1
set CMAKE_BUILD_TYPE=RelWithDebInfo
set USE_LAPACK=1
set CMAKE_C_COMPILER_LAUNCHER=sccache
set CMAKE_CXX_COMPILER_LAUNCHER=sccache

:: TODO: Dependencies
set PATH=%DEPENDENCY_SCCACHE_DIR%;%PATH%

:: change to source directory
cd %PYTORCH_SOURCES_DIR%
 
:: create virtual environment
python -m venv venv
echo * > venv\.gitignore
call .\venv\Scripts\activate
where python

set WHEELS_URL="https://github.com/cgohlke/win_arm64-wheels/releases/download/v2024.6.15/2024.6.15-experimental-cp312-win_arm64.whl.zip"
set ZIP_FILE="2024.6.15-experimental-cp312-win_arm64.whl.zip"
set EXTRACT_DIR="2024.6.15-experimental-cp312-win_arm64.whl"

if exist "%EXTRACT_DIR%" (
    echo Extraction directory "%EXTRACT_DIR%" already exists. Skipping download and installation.
    exit /b 0
) else (  
    echo Downloading ZIP file from %WHEELS_URL%...
    curl -L -o "%ZIP_FILE%" "%WHEELS_URL%"
:: Check if download was successful
    if %errorlevel% neq 0 (
      echo Failed to download the ZIP file.
      exit /b 1
    )

:: Unzip the file using tar
    echo Unzipping file %ZIP_FILE%...
    tar xf "%ZIP_FILE%"

:: Check if unzip was successful
    if %errorlevel% neq 0 (
      echo Failed to unzip the file.
      exit /b 1
    )
)

:: The ZIP file contained a folder with the same name as the file
cd "%EXTRACT_DIR%\%EXTRACT_DIR%"

:: python install dependencies
python -m pip install --upgrade pip

:: install numpy and Scipy experimental wheels
pip install numpy-2.0.0-cp312-cp312-win_arm64.whl
pip install scipy-1.13.1-cp312-cp312-win_arm64.whl

:: change back to source directory
cd %PYTORCH_SOURCES_DIR%

:: install pytorch dependencies
pip install -r requirements.txt
 
:: activate visual studio
set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -products * -latest -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)

:: TODO: vcvars_ver is optional but currently it is being tested with 14.36 and 14.40
call "%visualstudio%\VC\Auxiliary\Build\vcvarsall.bat" arm64 -vcvars_ver=14.40

:: show sccache stats
sccache --show-stats

if defined ENABLE_BUILD_WHEEL (
  echo ENABLE_BUILD_WHEEL is set, wheel is generating...

  python setup.py bdist_wheel

  :: rename wheel file
  cd %WHEEL_DIR%
  ren "torc*" %WHEEL_NAME%
  pip install %WHEEL_NAME%
  cd ..
) else (
  echo ENABLE_BUILD_WHEEL is not set, install command will be executed...

  python setup.py install
)