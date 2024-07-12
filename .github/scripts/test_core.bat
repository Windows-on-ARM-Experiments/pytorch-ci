:: change to source directory
cd %PYTORCH_SOURCES_DIR%

:: create virtual environment
python -m venv venv
echo * > venv\.gitignore
call .\venv\Scripts\activate
where python

:: change to test directory
cd test

set CORE_TEST_LIST=test_autograd.py test_modules.py test_ops_jit.py
@REM test_nn.py test_ops.py test_ops_gradients.py test_ops_fwd_gradients.py  test_torch.py

for /L %%i in (1,1,%1) do (
    for %%t in (%CORE_TEST_LIST%) do (
        echo Running test: %%t
        python %%t --verbose --save-xml --use-pytest -vvvv -rfEsxXP -p no:xdist
    )
)
