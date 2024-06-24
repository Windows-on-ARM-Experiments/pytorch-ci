set "SCRIPTS_DIR=%cd%\.github\scripts"

if "%1"=="bootstrap" (
    @REM call %SCRIPTS_DIR%\bootstrap_openblas.bat
    call %SCRIPTS_DIR%\bootstrap_pytorch.bat
)

@REM call %SCRIPTS_DIR%\build_openblas_msvc.bat
call %SCRIPTS_DIR%\build_pytorch.bat
