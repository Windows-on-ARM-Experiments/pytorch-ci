python -m pip install --upgrade pip
python -m pip install pytest pytest-shard pytest-rerunfailures pytest-flakefinder pytest-pytorch pytest-xdist expecttest hypothesis xdoctest

mkdir %GITHUB_WORKSPACE%\pytorch-unit-tests\tmp
cd %GITHUB_WORKSPACE%\pytorch-unit-tests\tmp

curl -L https://github.com/cgohlke/win_arm64.whl/releases/download/v2023.4.1/2023.4.1-experimental-cp311-win_arm64.whl.zip -o win_arm64.whl.zip
powershell Expand-Archive win_arm64.whl.zip -DestinationPath .

python -m pip uninstall numpy -y
python -m pip install 2023.4.1-experimental-cp311-win_arm64.whl\numpy-1.24.2-cp311-cp311-win_arm64.whl
python -m pip install 2023.4.1-experimental-cp311-win_arm64.whl\SciPy-1.10.1-cp311-cp311-win_arm64.whl

del %GITHUB_WORKSPACE%\pytorch-unit-tests\tmp /s /q /f
