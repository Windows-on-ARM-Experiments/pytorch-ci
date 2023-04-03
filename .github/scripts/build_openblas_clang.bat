set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -latest -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)

mkdir %GITHUB_WORKSPACE%\pytorch-unit-tests\openblas\build
cd %GITHUB_WORKSPACE%\pytorch-unit-tests\openblas\build

path=%path%;%visualstudio%\VC\Tools\Llvm\ARM64\bin

cmake ..  -G Ninja -DCMAKE_C_COMPILER=clang -DNOFORTRAN=1 -DDYNAMIC_ARCH=0 -DTARGET=ARMV8 -DARCH=arm64 -DBINARY=64 -DUSE_OPENMP=0 -DCMAKE_SYSTEM_PROCESSOR=ARM64 -DCMAKE_CROSSCOMPILING=1 -DCMAKE_SYSTEM_NAME=Windows
cmake --build . --config Release
cmake --install . --prefix ../install
