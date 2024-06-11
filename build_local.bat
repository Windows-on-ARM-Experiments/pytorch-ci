set "SCRIPTS_DIR=%cd%\.github\scripts"
set "JOB_DIR=%cd%\.."

if "%1"=="bootstrap" (
    call %SCRIPTS_DIR%\bootstrap_openblas.bat
    call %SCRIPTS_DIR%\bootstrap_pytorch.bat
)

call %SCRIPTS_DIR%\build_openblas_msvc.bat

set "ENABLE_OPENBLAS=true"

call %SCRIPTS_DIR%\build_pytorch.bat
