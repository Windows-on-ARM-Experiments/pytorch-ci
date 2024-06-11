set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -latest -products * -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)

call "%visualstudio%\VC\Auxiliary\Build\vcvarsall.bat" arm64

@echo on

mkdir %JOB_DIR%\openblas\build
cd %JOB_DIR%\openblas\build

if "%ENABLE_DEBUG%" == "true" (
  set CMAKE_BUILD_TYPE=Debug
  set CMAKE_CONFIG=Debug
) else (
  set CMAKE_BUILD_TYPE=RelWithDebInfo
  set CMAKE_CONFIG=Release
)

cmake .. -G Ninja  ^
  -DBUILD_TESTING=0 ^
  -DBUILD_BENCHMARKS=0 ^
  -DC_LAPACK=1 ^
  -DNOFORTRAN=1 ^
  -DDYNAMIC_ARCH=0 ^
  -DARCH=arm64 ^
  -DBINARY=64 ^
  -DTARGET=GENERIC ^
  -DUSE_OPENMP=0 ^
  -DCMAKE_VERBOSE_MAKEFILE=1 ^
  -DCMAKE_SYSTEM_PROCESSOR=ARM64 ^
  -DCMAKE_SYSTEM_NAME=Windows
cmake --build . --config %CMAKE_CONFIG%
cmake --install . --prefix ../install
