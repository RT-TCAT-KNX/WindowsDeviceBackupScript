#reads input from the last script via the .txt file
function Get-Folder-Path {
    Set-Variable backup_folder_name -Scope Script -Value (Get-Content -Path C:\backup_folder_location.txt)
}

Write-Host "Starting script..."
Write-Host "***Remember to run WingetInstallCaller first!***"
Write-Host "Locating backup folder..."
Get-Folder-Path

###########
#VARIABLES#
###########
$new_computer_name = $env:COMPUTERNAME
$new_username = $env:UserName
$appdata_filepath = -join("C:\Users\",$new_username,"\AppData")
#$old_computer_name_file = -join($backup_folder_name,"\computer_name.txt")
#$old_computer_name = Get-Content -Path $old_computer_name_file
#$old_username_file = -join($backup_folder_name,"\username.txt")
#$old_username = Get-Content -Path $old_username_file

#winget variables
$winget_package_file = -join($backup_folder_name,"\Installed_Packages.json")
$winget_errors_log_file = -join($backup_folder_name,"\Winget_Import_Errors_Log.txt")

#browser bookmark variables
$browser_bookmark_backup_title = "Browser Bookmarks"
$browser_bookmark_backup_folder = -join($backup_folder_name,"\",$browser_bookmark_backup_title)
$profiles = "Profiles"
$profiles_folder = -join($browser_bookmark_backup_folder,"\",$profiles)
$edge_bookmarks_rename = -join($appdata_filepath,"\Local\Microsoft\Edge\User Data\Default\Bookmarks")
$edge_bookmarks = -join($browser_bookmark_backup_folder,"\edge_Bookmarks")
$chrome_bookmarks_rename = -join($appdata_filepath,"\Local\Google\Chrome\User Data\Default\Bookmarks")
$chrome_bookmarks = -join($browser_bookmark_backup_folder,"\chrome_Bookmarks")
$firefox_profiles = -join($appdata_filepath,"\Roaming\Mozilla\Firefox\Profiles")
$new_firefox_profiles_ini = -join($appdata_filepath,"\Roaming\Mozilla\Firefox\profiles.ini")
$new_firefox_installs_ini = -join($appdata_filepath,"\Roaming\Mozilla\Firefox\installs.ini")
$old_firefox_profiles_ini = -join($browser_bookmark_backup_folder,"\profiles.ini")
$old_firefox_installs_ini = -join($browser_bookmark_backup_folder,"\installs.ini")

#############
#BASE Script#
#############
Write-Host	"Importing packages with winget. This may take a while."
winget import $winget_package_file --ignore-versions --accept-source-agreements --accept-package-agreements | Out-File $winget_errors_log_file

#Deletes relevant browser files
Write-Host "Restoring browser data..."
Remove-Item -Path $edge_bookmarks_rename -Force
Remove-Item -Path $chrome_bookmarks_rename -Force
#firefox functionality is not working yet
#Remove-Item -Path $new_firefox_installs_ini -Force
#Remove-Item -Path $new_firefox_profiles_ini -Force

#Copies relevant browser files
Copy-Item -Force $edge_bookmarks -Destination $edge_bookmarks_rename
Copy-Item -Force $chrome_bookmarks -Destination $chrome_bookmarks_rename
#firefox functionality is not working yet
#Copy-Item -Force $old_firefox_profiles_ini -Destination $new_firefox_profiles_ini
#Copy-Item -Force $old_firefox_installs_ini -Destination $new_firefox_installs_ini
#robocopy $profiles_folder $firefox_profiles /e /r:1 /COPYALL

Write-Host "The script has finished running!"
