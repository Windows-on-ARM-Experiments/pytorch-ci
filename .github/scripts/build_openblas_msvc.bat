set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -latest -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)

call "%visualstudio%\VC\Auxiliary\Build\vcvarsall.bat" arm64

mkdir %GITHUB_WORKSPACE%\pytorch-unit-tests\openblas\build
cd %GITHUB_WORKSPACE%\pytorch-unit-tests\openblas\build

cmake .. -G Ninja -DBUILD_TESTING=0
cmake --build . --config Release
cmake --install . --prefix ../install
