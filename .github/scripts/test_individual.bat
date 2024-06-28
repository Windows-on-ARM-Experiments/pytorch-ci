:: change to source directory
cd %PYTORCH_SOURCES_DIR%


:: Check if torch module is available
python -c "import torch" > nul 2>&1
if errorlevel 1 (
    echo Torch module not found in local env
    exit /b 1
) else (
    echo Torch module found locally.
)

:: create virtual environment
python -m venv venv
echo * > venv\.gitignore
call .\venv\Scripts\activate


:: Check if torch module is available
.\venv\Scripts\python.exe -c "import torch" > nul 2>&1
if errorlevel 1 (
    echo Torch module not found after venv
    exit /b 1
) else (
    echo Torch module found in venv.
)


echo Debug: Before python path
where python
echo Debug: After python path
echo Current directory path: %CD%
:: change to test directory
cd test

echo Current directory path: %CD%

if "%3"=="" (
    python run_test.py -i %2 --verbose --save-xml --keep-going --runs %1
) else (
    python run_test.py -i %2 --verbose --save-xml --keep-going --runs %1 --filter "%3"
)

:: deactivate and delete the virtual environment
deactivate
rd /s /q venv