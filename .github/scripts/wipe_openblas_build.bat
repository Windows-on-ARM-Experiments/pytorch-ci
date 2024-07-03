@echo on

if exist [%OPENBLAS_BUILD_DIR%] (
  rmdir /s /q %OPENBLAS_BUILD_DIR%
)
