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

python setup.py install --cmake --home=%GITHUB_WORKSPACE%\pytorch-unit-tests\pytorch\install  
python setup.py install
