del %PYTORCH_SOURCES_DIR%\test\test-reports\* /s /q /f

set CI=true

@echo Started: %date% %time%

if "%2%3"=="" (
    call %JOB_DIR%\workflow\.github\scripts\test_core.bat %1
) else (
    call %JOB_DIR%\workflow\.github\scripts\test_individual.bat %1 %2 %3
)

@echo Completed: %date% %time%
