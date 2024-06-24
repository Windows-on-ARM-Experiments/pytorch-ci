:: change to source directory
cd %PYTORCH_SOURCES_DIR%

:: create virtual environment
python -m venv venv
echo * > venv\.gitignore
call .\venv\Scripts\activate
where python

:: install dependencies
pip install pytest==8.1.1 pytest-xdist==3.5.0 pytest-shard pytest-rerunfailures==13.0 pytest-flakefinder pytest-pytorch expecttest hypothesis xdoctest