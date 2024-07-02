set "SCRIPTS_DIR=%cd%\.github\scripts"

if "%1"=="bootstrap" (
    call %SCRIPTS_DIR%\bootstrap_tests.bat
)

call %SCRIPTS_DIR%\test_core.bat %1