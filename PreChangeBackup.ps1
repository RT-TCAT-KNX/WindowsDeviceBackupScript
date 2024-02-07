#variables

$computer_name = $env:COMPUTERNAME
$users_name = $env:UserName
$appdata_filepath = -join("C:\Users\",$users_name,"\AppData")
$backup_folder_name = -join("D:\",$computer_name)
$appdata_backup_folder_name = -join($backup_folder_name, "\AppData")
$username_filename = -join($backup_folder_name,"\","username.txt")
$winget_package_file = -join($backup_folder_name,"\",$computer_name,"_Installed_Packages.json")
$winget_errors_log_file = -join($backup_folder_name,"\",$computer_name,"_Winget_Import_Errors_Log.txt")

Write-Host "Starting script..."
New-Item -Path "D:\" -Name $computer_name -ItemType directory
$users_name | Out-File $username_filename
winget export -o $winget_package_file --include-versions --accept-source-agreements | Out-File $winget_errors_log_file

#Pick one of the lines below, but both are very slow. File Explorer is the fastest right now.
#robocopy $appdata_filepath $backup_folder_name * /E /w:0 /r:1 /COPYALL /mt:8
#Copy-Item -Force -Recurse -Verbose $appdata_filepath -Destination $backup_folder_name

Write-Host "The script has run successfully!"
Write-Host "Now copy the $appdata_filepath folder to the drive." #Once I fix the copy function, I will remove this