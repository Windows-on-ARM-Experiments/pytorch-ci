:: change to source directory
cd %PYTORCH_SOURCES_DIR%

:: create virtual environment
call .\venv\Scripts\activate
where python

python -c "import torch" > nul 2>&1
if errorlevel 1 (
    echo Torch module not found in local env
    exit /b 1
) else (
    echo Torch module found locally.
)

:: change to test directory
cd test

if "%3"=="" (
    python run_test.py -i %2 --verbose --save-xml --keep-going --runs %1
) else (
    python run_test.py -i %2 --verbose --save-xml --keep-going --runs %1 --filter "%3" 
)
