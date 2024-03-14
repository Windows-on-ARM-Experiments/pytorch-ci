pip uninstall torch -y
pip uninstall pytorch -y

if exist [%JOB_DIR%\pytorch\build] (
  rmdir /S /q %JOB_DIR%\pytorch\build
)
if exist [%JOB_DIR%\pytorch\install] (
  rmdir /S /q %JOB_DIR%\pytorch\install
)

cd %JOB_DIR%\pytorch

python -m pip install --upgrade pip
python -m pip install -r requirements.txt
