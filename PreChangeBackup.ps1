function Confirm-Drive-Path {
Do {
$drive_response = Read-Host "Enter removable storage drive filepath (i.e. D:\, F:\, etc.)"
$confirmation = Read-Host "You entered $drive_response. Is this correct? y/n: "
}
Until ($confirmation -eq "y" -and (Test-Path $drive_response))
$global:my_drive = $drive_response
}

#variables

$computer_name = $env:COMPUTERNAME
$users_name = $env:UserName
$appdata_filepath = -join("C:\Users\",$users_name,"\AppData")
$backup_folder_name = -join($my_drive,$computer_name)
$appdata_backup_folder_name = -join($backup_folder_name, "\AppData")
$username_filename = -join($backup_folder_name,"\","username.txt")
$winget_filename = -join($backup_folder_name,"\",$computer_name,"_Installed_Packages.txt")

Write-Host "Starting script..."
Confirm-Drive-Path
New-Item -Path $my_drive -Name $computer_name -ItemType directory
$users_name | Out-File $username_filename
winget list | Out-File $winget_filename

#Pick one of the lines below, but both are very slow. File Explorer is the fastest right now.
#robocopy $appdata_filepath $backup_folder_name * /E /w:0 /r:1 /COPYALL /mt:8
#Copy-Item -Force -Recurse -Verbose $appdata_filepath -Destination $backup_folder_name

Write-Host "The script has run successfully!"
Write-Host "Now copy the $appdata_filepath folder to the drive." #Once I fix the copy function, I will remove this