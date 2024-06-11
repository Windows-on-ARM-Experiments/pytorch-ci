@echo on

if exist [%PYTORCH_BUILD_DIR%] (
  rmdir /S /q %PYTORCH_BUILD_DIR%
)
