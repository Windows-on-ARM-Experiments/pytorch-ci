@echo on

set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -latest -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)

if "%ENABLE_APL%" == "1" (
  set PATH=%PATH%;%ARMPL_DIR%\bin
)

call "%visualstudio%\VC\Auxiliary\Build\vcvarsall.bat" arm64

cd %JOB_DIR%\pytorch

set REL_WITH_DEB_INFO=1
set CMAKE_BUILD_TYPE=RelWithDebInfo

echo %ENABLE_OPENBLAS%

if "%ENABLE_OPENBLAS%" == "1" (
  set BLAS=OpenBLAS
  set OpenBLAS_HOME=%JOB_DIR%\openblas\install
)

:: start sccache server and reset sccache stats
set PATH=%PATH%;C:\sccache
sccache --zero-stats

set USE_CUDA=OFF
set USE_DISTRIBUTED=OFF
set USE_FAKELOWP=OFF
set USE_FBGEMM=OFF
set USE_MAGMA=OFF
set USE_METAL=OFF
set USE_MKLDNN=OFF
set USE_NNPACK=OFF
set USE_PYTORCH_QNNPACK=OFF
set USE_QNNPACK=OFF
set USE_ROCM=OFF
set USE_TENSORPIPE=OFF
set USE_XNNPACK=OFF
set BUILD_PYTHON=False
set CMAKE_GENERATOR=Ninja
set CMAKE_C_COMPILER_LAUNCHER=sccache
set CMAKE_CXX_COMPILER_LAUNCHER=sccache
set CMAKE_CUDA_COMPILER_LAUNCHER=sccache
python setup.py install --cmake --home=%JOB_DIR%\pytorch\install

:: show sccache stats
sccache --show-stats

python setup.py install

