@echo on

if exist [%OPENBLAS__BUILD_DIR%] (
  rmdir /S /q %OPENBLAS__BUILD_DIR%
)
