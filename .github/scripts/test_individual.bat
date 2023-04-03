@echo off

if "%2"=="" (
    python run_test.py -i %1 --verbose --save-xml --keep-going 
) else (
    python run_test.py -i %1 --verbose --save-xml --keep-going --filter "%2"
)
