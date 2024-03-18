@echo on

if exist [%OPENBLAS_SOURCES_DIR%] (
  rmdir /S /q %OPENBLAS_SOURCES_DIR%
)
