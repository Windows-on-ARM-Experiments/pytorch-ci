@echo on

if exist [%OPENBLAS__BUILD_DIR%] (
  rmdir /s /q %OPENBLAS__BUILD_DIR%
)
