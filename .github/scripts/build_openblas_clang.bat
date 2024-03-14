set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -latest -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)

@echo on

mkdir %JOB_DIR%\openblas\build
cd %JOB_DIR%\openblas\build

set PATH=%PATH%;%visualstudio%\VC\Tools\Llvm\ARM64\bin

if "%ENABLE_DEBUG%" == "true" (
  set CMAKE_BUILD_TYPE=Debug
  set CMAKE_CONFIG=Debug
) else (
  set CMAKE_BUILD_TYPE=RelWithDebInfo
  set CMAKE_CONFIG=Release
)

cmake ..  -G Ninja ^
  -DCMAKE_C_COMPILER=clang ^
  -DNOFORTRAN=1 ^
  -DDYNAMIC_ARCH=0 ^
  -DTARGET=ARMV8 ^
  -DARCH=arm64 ^
  -DBINARY=64 ^
  -DUSE_OPENMP=0 ^
  -DCMAKE_VERBOSE_MAKEFILE=1 ^
  -DCMAKE_SYSTEM_PROCESSOR=ARM64 ^
  -DCMAKE_CROSSCOMPILING=1 ^
  -DCMAKE_SYSTEM_NAME=Windows
cmake --build . --config %CMAKE_CONFIG%
cmake --install . --prefix ../install
