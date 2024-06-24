@echo on
:: start sccache server and reset sccache stats
sccache --zero-stats

:: environment variables
:: TODO: OpenBLAS implementation will be applied
set BLAS=APL
set REL_WITH_DEB_INFO=1
set CMAKE_BUILD_TYPE=RelWithDebInfo
set USE_LAPACK=1
set USE_NUMPY=OFF
set CMAKE_C_COMPILER_LAUNCHER=sccache
set CMAKE_CXX_COMPILER_LAUNCHER=sccache

:: TODO: Dependencies
set PATH=C:\_WORK\dependencies\sccache;%PATH%
set PATH=C:\_WORK\dependencies\apl\armpl_24.04\bin;%PATH%

:: change to source directory
cd %PYTORCH_SOURCES_DIR%
 
:: create virtual environment
python -m venv venv
echo * > venv\.gitignore
call .\venv\Scripts\activate
where python

:: python install dependencies
pip install -r requirements.txt
 
:: activate visual studio
set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -products Microsoft.VisualStudio.Product.BuildTools -latest -property installationPath') do set "visualstudio=%%v"
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
  cd ..
) else (
  echo ENABLE_BUILD_WHEEL is not set, install command will be executed...

  python setup.py install
)