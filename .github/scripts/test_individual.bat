:: change to source directory
cd %PYTORCH_SOURCES_DIR%

:: create virtual environment
call .\venv\Scripts\activate
where python

:: Change to the test directory
cd test

:: Run individual test suite 
for /L %%i in (1,1,%1) do (
    if "%3" neq "" (
        echo Running iteration %%i with filter %3
        python %2.py -k "%3" --verbose --save-xml --use-pytest -vvvv -rfEsxXP -p no:xdist
    ) else (
        echo Running iteration %%i
        python %2.py --verbose --save-xml --use-pytest -vvvv -rfEsxXP -p no:xdist
    )
)
