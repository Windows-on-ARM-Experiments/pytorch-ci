@echo on

if exist [%PYTORCH_BUILD_DIR%] (
  rmdir /s /q %PYTORCH_BUILD_DIR%
)
