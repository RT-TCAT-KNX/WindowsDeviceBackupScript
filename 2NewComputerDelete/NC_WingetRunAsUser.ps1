#reads input from the last script via the .txt file
function Get-Folder-Path {
    Set-Variable backup_folder_name -Scope Script -Value (Get-Content -Path C:\backup_folder_location.txt)
}

Write-Host "Starting script..."
Write-Host "***Remember to start NC_InitialRestore first!***"
Write-Host "Locating backup folder..."
Get-Folder-Path

###########
#VARIABLES#
###########
$new_computer_name = $env:COMPUTERNAME
$new_username = $env:UserName
$appdata_filepath = -join("C:\Users\",$new_username,"\AppData")
$new_username_filename = -join($backup_folder_name,"\","new_username.txt")
#$old_computer_name_file = -join($backup_folder_name,"\computer_name.txt")
#$old_computer_name = Get-Content -Path $old_computer_name_file
#$old_username_file = -join($backup_folder_name,"\username.txt")
#$old_username = Get-Content -Path $old_username_file

#winget variables
$winget_install_log = -join($backup_folder_name,"\new-winget-installation-log.txt")
$winget_package_file = -join($backup_folder_name,"\Installed_Packages.json")
$winget_errors_log_file = -join($backup_folder_name,"\Winget_Import_Errors_Log.txt")

#############
#BASE Script#
#############
$new_username | Out-File $new_username_filename

Write-Host "Installing winget..."
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

Write-Host	"Importing packages with winget. This may take a while."
winget import $winget_package_file --ignore-versions --accept-source-agreements --accept-package-agreements | Out-File $winget_errors_log_file

Write-Host "The script has finished running!"
