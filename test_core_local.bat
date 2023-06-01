set "SCRIPTS_DIR=%cd%\.github\scripts"
set "JOB_DIR=%cd%\.."

if "%1"=="bootstrap" (
    call %SCRIPTS_DIR%\bootstrap_tests.bat
)

call %SCRIPTS_DIR%\test_core.bat
