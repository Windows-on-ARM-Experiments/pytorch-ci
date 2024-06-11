if exist [%JOB_DIR%\openblas\build] (
  rmdir /S /q %JOB_DIR%\openblas\build
)
if exist [%JOB_DIR%\openblas\install] (
  rmdir /S /q %JOB_DIR%\openblas\install
)
