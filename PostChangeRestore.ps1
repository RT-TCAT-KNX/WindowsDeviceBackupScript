function Confirm-Drive-Path {
Do {
$drive_response = Read-Host "Enter removable storage drive filepath (i.e. D:\, F:\, etc.)"
$confirmation = Read-Host "You entered $drive_response. Is this correct? y/n: "
}
Until ($confirmation -eq "y" -and (Test-Path $drive_response))
$global:my_drive = $drive_response
}

#variables
$computer_name #Get-Content from file or something
$users_name = $env:UserName #Get-Content from file or something
$backup_folder_name = -join($my_drive,$computer_name)
$old_winget_filename = -join($backup_folder_name,"\",$computer_name,"_Installed_Packages.txt")
$new_winget_filename = -join($backup_folder_name,"\Preinstalled_Packages.txt")
$diff_winget_filename = -join($backup_folder_name,"\Diff_Packages.txt")
$appdata_filepath = -join("C:\Users\",$users_name,"\AppData")

$appdata_backup_folder_name = -join($backup_folder_name, "\AppData")
$username_filename = -join($backup_folder_name,"\","username.txt")

function Winget-Diff {
	Compare-Object (Get-Content $new_winget_filename) (Get-Content $old_winget_filename) | Out-File $diff_winget_filename
}

#I might just run this function in another file
<# function Read-Winget-File {
	for ()
	{
		winget install $package_id
	}
} #>

Write-Host "Starting script..."
Confirm-Drive-Path
winget list | Out-File $new_winget_filename
Winget-Diff

#Pick one of the lines below, but both are very slow. File Explorer is the fastest right now.
#robocopy $appdata_filepath $backup_folder_name * /E /w:0 /r:1 /COPYALL /mt:8
#Copy-Item -Force -Recurse -Verbose $appdata_filepath -Destination $backup_folder_name

Write-Host "The script has run successfully!"
Write-Host "Now replace the AppData folder with your backup at $appdata_backup_folder_name." #Once I fix the copy function, I will remove this