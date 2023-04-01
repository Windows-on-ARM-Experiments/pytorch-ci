@echo off

call %GITHUB_WORKSPACE%\pytorch-unit-tests\workflow\.github\scripts\cleanup_pytorch.bat

python -m pip install --upgrade pip
python -m pip install -r requirements.txt
