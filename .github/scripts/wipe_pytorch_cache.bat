@echo on

if exist [%JOB_DIR%\pytorch\build\] (
  del %JOB_DIR%\pytorch\build\* /s /q /f
)
