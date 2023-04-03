@echo off

@echo Started: %date% %time%

if "%1%2"=="" (
    %GITHUB_WORKSPACE%\pytorch-unit-tests\workflow\.github\scripts\test_core.bat
) else (
    %GITHUB_WORKSPACE%\pytorch-unit-tests\workflow\.github\scripts\test_individual.bat %1 %2
)

@echo Completed: %date% %time%
