@echo off

set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -latest -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)


call "%visualstudio%\VC\Auxiliary\Build\vcvarsall.bat" arm64

mkdir build
cd build

call cmake -G Ninja -DBUILD_TESTING=0 ..
call cmake --build . --config Release
call cmake --install . --prefix ../install
