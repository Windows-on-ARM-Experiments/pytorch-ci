:: change to source directory
cd %PYTORCH_SOURCES_DIR%

@REM python -c "import torch" > nul 2>&1
@REM if errorlevel 1 (
@REM     echo Torch module not found in local env
@REM     exit /b 1
@REM ) else (
@REM     echo Torch module found locally.
@REM )

:: create virtual environment
python -m venv venv
echo * > venv\.gitignore
call .\venv\Scripts\activate
echo Debug: Before python path
where python
echo Debug: After python path

python -c "import torch" > nul 2>&1
if errorlevel 1 (
    echo  Torch module not found in venv
    exit /b 1
) else (
    echo Torch module found in venv.
)

:: change to test directory
cd test

if "%3"=="" (
    python run_test.py -i %2 --verbose --save-xml --keep-going --runs %1
) else (
    python run_test.py -i %2 --verbose --save-xml --keep-going --runs %1 --filter "%3" 
)
