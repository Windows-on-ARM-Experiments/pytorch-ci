pip uninstall torch -y
pip uninstall pytorch -y

del %GITHUB_WORKSPACE%\pytorch-unit-tests\pytorch\install\* /s /q /f

python -m pip install --upgrade pip
python -m pip install -r requirements.txt
