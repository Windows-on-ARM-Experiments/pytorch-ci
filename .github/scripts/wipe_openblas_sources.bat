@echo off

if exist [%OPENBLAS_SOURCES_DIR%] (
  rmdir /s /q %OPENBLAS_SOURCES_DIR%
)
