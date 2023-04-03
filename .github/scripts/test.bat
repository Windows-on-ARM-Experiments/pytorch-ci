del %GITHUB_WORKSPACE%\pytorch-unit-tests\pytorch\test\test-reports\* /s /q /f

set CI=true

@echo Started: %date% %time%

if "%1%2"=="" (
    call %GITHUB_WORKSPACE%\pytorch-unit-tests\workflow\.github\scripts\test_core.bat
) else (
    call %GITHUB_WORKSPACE%\pytorch-unit-tests\workflow\.github\scripts\test_individual.bat %1 %2 %3
)

@echo Completed: %date% %time%
