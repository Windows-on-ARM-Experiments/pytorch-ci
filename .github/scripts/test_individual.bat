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
    python %2 --verbose -vvvv -rfEsxXP -p no:xdist --use-pytest --save-xml -k "deadlock"
) else (
    python run_test.py -i %2 --verbose --save-xml --keep-going --runs %1 --filter "%3" 
)