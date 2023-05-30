del %JOB_DIR%\pytorch\test\test-reports\* /s /q /f

set CI=true

@echo Started: %date% %time%

if "%2%3"=="" (
    call %JOB_DIR%\workflow\.github\scripts\test_core.bat
) else (
    call %JOB_DIR%\workflow\.github\scripts\test_individual.bat %1 %2 %3
)

@echo Completed: %date% %time%
