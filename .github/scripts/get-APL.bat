@echo on
set FILE_NAME=arm-performance-libraries_23.10_Windows
set FILE_URL=https://armkeil.blob.core.windows.net/developer/Files/downloads/hpc/arm-performance-libraries/23-10/windows/arm-performance-libraries_23.10_Windows.zip
set ZIP_FILE=arm-performance-libraries_23.10_Windows.zip
set DEST_DIR=%JOB_DIR%

:: Check if the ZIP file already exists in the destination directory
::if not exist "%DEST_DIR%%ZIP_FILE%" (
    echo File not found. Downloading...
    curl -L -o "%ZIP_FILE%" "%FILE_URL%"
    echo Unzipping the file...
	tar -xf "%ZIP_FILE%" -C %DEST_DIR%
	del %ZIP_FILE%
	
::) else (
::    echo File already exists. Skipping download and unzip.
::)
set PATH=%PATH%;%DEST_DIR%\%FILE_NAME%\armpl_23.10
echo Done.