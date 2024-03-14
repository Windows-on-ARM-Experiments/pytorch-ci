set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set visualstudio=
for /f "delims=" %%v in ('"%vswhere%" -latest -products * -property installationPath') do set "visualstudio=%%v"
if "%visualstudio%" == "" (
  echo Visual Studio not found!
  goto :eof
)

call "%visualstudio%\VC\Auxiliary\Build\vcvarsall.bat" arm64

@echo on

cd %JOB_DIR%\pytorch

if "%ENABLE_DEBUG%" == "true" (
  set DEBUG=ON
  set REL_WITH_DEB_INFO=OFF
  set CMAKE_BUILD_TYPE=Debug
) else (
  set DEBUG=OFF
  set REL_WITH_DEB_INFO=ON
  set CMAKE_BUILD_TYPE=RelWithDebInfo
)

if "%ENABLE_OPENBLAS%" == "true" (
  set BLAS=OpenBLAS
  set OpenBLAS_HOME=%JOB_DIR%\openblas\install
)

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

set CMAKE_VERBOSE_MAKEFILE:BOOL=ON

python setup.py install --cmake --home=%JOB_DIR%\pytorch\install
python setup.py install
