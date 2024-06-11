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

:: change to source directory
cd pytorch

:: submodule sync
git submodule sync
git submodule update --init --recursive
 
:: create virtual environment
python -m venv venv
echo * > venv\.gitignore
call .\venv\Scripts\activate

:: python install dependencies
pip install -r requirements.txt
pip install pytest==8.1.1 pytest-xdist==3.5.0 pytest-shard pytest-rerunfailures==13.0 pytest-flakefinder pytest-pytorch expecttest hypothesis xdoctest
 
:: activate visual studio
set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -products Microsoft.VisualStudio.Product.BuildTools -latest -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)

:: TODO: vcvars_ver is optional but currently it is being tested with 14.36 and 14.40
cmd /k "%visualstudio%\VC\Auxiliary\Build\vcvarsall.bat" arm64 -vcvars_ver=14.40

:: show sccache stats
sccache --show-stats

python setup.py bdist_wheel

