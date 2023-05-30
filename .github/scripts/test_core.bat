cd %JOB_DIR%\pytorch\test

python run_test.py --core --verbose --save-xml --keep-going %*
