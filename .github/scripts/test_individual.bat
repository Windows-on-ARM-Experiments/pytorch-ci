:: change to source directory
cd %PYTORCH_SOURCES_DIR%

:: create virtual environment
python -m venv venv
echo * > venv\.gitignore
call .\venv\Scripts\activate
where python

:: change to test directory
cd test

if "%3"=="" (
    python run_test.py -i %2 --verbose --save-xml --keep-going --runs %1
) else (
    python run_test.py -i %2 --verbose --save-xml --keep-going --runs %1 --filter "%3" 
)