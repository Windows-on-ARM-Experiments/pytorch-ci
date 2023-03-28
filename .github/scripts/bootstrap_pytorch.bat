@echo off

call cleanup_pytorch.bat

python -m pip install --upgrade pip
python -m pip install -r requirements.txt
