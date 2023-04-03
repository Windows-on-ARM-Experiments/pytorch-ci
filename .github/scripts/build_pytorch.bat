@echo off

set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -latest -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)

call "%visualstudio%\VC\Auxiliary\Build\vcvarsall.bat" arm64

set BLAS=OpenBLAS
set OpenBLAS_HOME=%GITHUB_WORKSPACE%\pytorch-unit-tests\openblas\install

python setup.py install --cmake
