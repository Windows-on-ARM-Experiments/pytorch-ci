set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -latest -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)

call "%visualstudio%\VC\Auxiliary\Build\vcvarsall.bat" arm64

mkdir %JOB_DIR%\openblas\build
cd %JOB_DIR%\openblas\build

set CMAKE_BUILD_TYPE=RelWithDebInfo

cmake .. -G Ninja -DBUILD_TESTING=0
cmake --build . --config Release
cmake --install . --prefix ../install
