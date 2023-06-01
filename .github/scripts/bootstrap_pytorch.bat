pip uninstall torch -y
pip uninstall pytorch -y

del %JOB_DIR%\pytorch\install\* /s /q /f

cd %JOB_DIR%\pytorch
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
