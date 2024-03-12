set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -latest -products Microsoft.VisualStudio.Product.BuildTools -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)

call "%visualstudio%\VC\Auxiliary\Build\vcvarsall.bat" amd64_arm64

@echo on

mkdir %JOB_DIR%\openblas\build
cd %JOB_DIR%\openblas\build

set CMAKE_BUILD_TYPE=RelWithDebInfo

cmake .. -G Ninja ^
  -DNOFORTRAN=1 ^
  -DDYNAMIC_ARCH=0 ^
  -DTARGET=GENERIC ^
  -DARCH=arm64 ^
  -DBINARY=64 ^
  -DUSE_OPENMP=0 ^
  -DCMAKE_SYSTEM_PROCESSOR=ARM64 ^
  -DCMAKE_CROSSCOMPILING=1 ^
  -DCMAKE_SYSTEM_NAME=Windows ^
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
cmake --build . --config RelWithDebInfo
cmake --install . --prefix ../install
