if "%3"=="" (
    python run_test.py -i %1 --verbose --save-xml --keep-going --runs %2
) else (
    python run_test.py -i %1 --verbose --save-xml --keep-going --runs %2 --filter "%3" 
)
