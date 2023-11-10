#Comments like this

Write-Host "Starting script..."

#variables
#TODO throw error if drive not connected
$computer_name = $env:COMPUTERNAME
$users_name = $env:UserName
$app_data_filepath = -join("C:\Users\",$users_name,"\AppData")
$backup_folder_name = -join("D:\",$computer_name,"\")
$winget_filename = -join($backup_folder_name,$computer_name,"_Installed_Packages.txt")

New-Item -Path D:\ -Name $computer_name -ItemType directory
winget list | Out-File $winget_filename
Copy-Item $app_data_filepath -destination $backup_folder_name
Write-Host "The script has run successfully!"

#TODO check IF filesizes are too big
#ELSE, throw error list other apps