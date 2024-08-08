# For now, APL is considered as already installed (script is not in use)

Write-Output "Dependency APL installation is started."

# Pre check for downloads and dependencies folders
if (-not (Test-Path -Path $env:DOWNLOADS_DIR)) {
    New-Item -ItemType Directory -Path $env:DOWNLOADS_DIR
}
if (-not (Test-Path -Path $env:DEPENDENCIES_DIR)) {
    New-Item -ItemType Directory -Path $env:DEPENDENCIES_DIR
}

# Check if the Windows Installer Service is running
$service = Get-Service -Name msiserver -ErrorAction SilentlyContinue
if ($service.Status -eq 'Running') {
    Write-Output "Windows Installer Service is already running."
} else {
    Write-Output "Attempting to start the Windows Installer Service..."
    Start-Service -Name msiserver
    if ((Get-Service -Name msiserver).Status -eq 'Running') {
        Write-Output "Windows Installer Service started successfully."
    } else {
        Write-Output "Failed to start the Windows Installer Service. Please check your permissions and try again."
        exit 1
    }
}

$DOWNLOAD_URL = "https://developer.arm.com/-/cdn-downloads/permalink/Arm-Performance-Libraries/Version_24.04/arm-performance-libraries_24.04_Windows.msi"
$TARGET_DIR = "apl\armpl_24.04\bin"
$TARGET_FILE = "armpl-info.exe"

# Check if the file already exists in the destination directory
if (-not (Test-Path -Path "$env:DEPENDENCIES_DIR\$TARGET_DIR\$TARGET_FILE")) {
    Write-Output "Downloading arm-performance-libraries_24.04_Windows.msi..."
    Invoke-WebRequest -Uri $DOWNLOAD_URL -OutFile "$env:DOWNLOADS_DIR\arm-performance-libraries_24.04_Windows.msi"

    Write-Output "Installing APL 24.04..."
    msiexec /i $env:DOWNLOADS_DIR\arm-performance-libraries_24.04_Windows.msi /quiet /qn /norestart /log $env:DOWNLOADS_DIR\apl_install.log
}
else {
    Write-Output "APL 24.04 is already installed."
}

Write-Output "Dependency APL installation is finished."