# For now, APL is considered as already installed (script is not in use)

Write-Output "Dependency APL installation is started."

# Pre check for downloads and dependencies folders
if (-not (Test-Path -Path $env:DOWNLOADS_DIR)) {
    New-Item -ItemType Directory -Path $env:DOWNLOADS_DIR
}
if (-not (Test-Path -Path $env:DEPENDENCIES_DIR)) {
    New-Item -ItemType Directory -Path $env:DEPENDENCIES_DIR
}

$DOWNLOAD_URL = "https://developer.arm.com/-/cdn-downloads/permalink/Arm-Performance-Libraries/Version_24.04/arm-performance-libraries_24.04_Windows.msi"
$TARGET_DIR = "apl\armpl_24.04\bin"
$TARGET_FILE = "armpl-info.exe"

# Check if the file already exists in the destination directory
if (-not (Test-Path -Path "$env:DEPENDENCIES_DIR\$TARGET_DIR\$TARGET_FILE")) {
    Write-Output "Downloading arm-performance-libraries_24.04_Windows.msi..."
    Invoke-WebRequest -Uri $DOWNLOAD_URL -OutFile "$env:DOWNLOADS_DIR\arm-performance-libraries_24.04_Windows.msi"

    Write-Output "Installing APL 24.04..."
    # Add installation command here
}