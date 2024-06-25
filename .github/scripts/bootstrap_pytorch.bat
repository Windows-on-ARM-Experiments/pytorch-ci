@echo off

if exist [%PYTORCH_SOURCES_DIR%] (
    cd %PYTORCH_SOURCES_DIR%
    git clean -fxd
    cd ..
)