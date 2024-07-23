:: !! must be run as administrator !!
:: download and installs needed dependencies for building pytorch for WOnArm64
echo Bootstrapping APL... 

echo APL bootstrapping done
echo Bootstrapping BuildTools... 
bootstrap_buildtools.bat
echo BuildTools bootstrapping done
@echo off
setlocal

echo Starting downloading dependencies

:: Download BuildTools 
call bootstrap_buildtools.bat

:: Check if the secondary script gave an error
if %errorlevel% neq 0 (
    echo Script failed with error code %errorlevel%.
    endlocal
    exit /b 1
) else (
    echo Bootstrapping Buildtools done
)

:: Download APL
call bootstrap_apl.bat

:: Check if the secondary script gave an error
if %errorlevel% neq 0 (
    echo Script failed with error code %errorlevel%.
    endlocal
    exit /b 1
) else (
    echo Bootstrapping APL done
)

:: Download sccache
call bootstrap_sccache.bat

:: Check if the secondary script gave an error
if %errorlevel% neq 0 (
    echo Script failed with error code %errorlevel%.
    endlocal
    exit /b 1
) else (
    echo Bootstrapping sccache done
)

:: Download ninja
call bootstrap_ninja.bat

:: Check if the secondary script gave an error
if %errorlevel% neq 0 (
    echo Script failed with error code %errorlevel%.
    endlocal
    exit /b 1
) else (
    echo Bootstrapping ninja done
)

:: Download additional wheels
:: Needed for running the tests
:: Scipy not currently fully supported for arm64
:: Numpy 2 can be installed normally via pip

call bootstrap_wheels.bat

:: Check if the secondary script gave an error
if %errorlevel% neq 0 (
    echo Script failed with error code %errorlevel%.
    endlocal
    exit /b 1
) else (
    echo Bootstrapping external wheels done
)

endlocal
exit /b 0