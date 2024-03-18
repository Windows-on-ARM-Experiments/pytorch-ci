@echo on

if exist [%PYTORCH_SOURCES_DIR%] (
  rmdir /S /q %PYTORCH_SOURCES_DIR%
)
