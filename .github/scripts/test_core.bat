:: change to source directory
cd %PYTORCH_SOURCES_DIR%

:: create virtual environment
python -m venv venv
echo * > venv\.gitignore
call .\venv\Scripts\activate
where python

:: change to test directory
cd test

python run_test.py --core --verbose --save-xml --keep-going %*
