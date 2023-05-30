cd %JOB_DIR%\pytorch\test

if "%3"=="" (
    python run_test.py -i %2 --verbose --save-xml --keep-going --runs %1
) else (
    python run_test.py -i %2 --verbose --save-xml --keep-going --runs %1 --filter "%3" 
)
