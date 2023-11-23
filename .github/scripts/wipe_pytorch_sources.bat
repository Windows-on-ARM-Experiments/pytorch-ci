@echo on

if exist [%PYTORCH_SOURCES_DIR%] (
  rmdir /s /q %PYTORCH_SOURCES_DIR%
)
