###########
#VARIABLES#
###########
$computer_name = $env:COMPUTERNAME
$users_name = $env:UserName
$appdata_filepath = -join("C:\Users\",$users_name,"\AppData")
$backup_folder_name = -join("D:\",$computer_name)
$computer_name_filename = -join($backup_folder_name,"\","computer_name.txt")
$username_filename = -join($backup_folder_name,"\","username.txt")

#winget variables
$winget_package_file = -join($backup_folder_name,"\Installed_Packages.json")
$winget_errors_log_file = -join($backup_folder_name,"\Winget_Export_Errors_Log.txt")

#browser bookmark variables
$browser_bookmark_backup_title = "Browser Bookmarks"
$browser_bookmark_backup_folder = -join($backup_folder_name,"\",$browser_bookmark_backup_title)
$profiles = "Profiles"
$profiles_folder = -join($browser_bookmark_backup_folder,"\",$profiles)
$edge_bookmarks = -join($appdata_filepath,"\Local\Microsoft\Edge\User Data\Default\Bookmarks")
$edge_bookmarks_rename = -join($browser_bookmark_backup_folder,"\edge_Bookmarks")
$chrome_bookmarks = -join($appdata_filepath,"\Local\Google\Chrome\User Data\Default\Bookmarks")
$chrome_bookmarks_rename = -join($browser_bookmark_backup_folder,"\chrome_Bookmarks")
$firefox_profiles = -join($appdata_filepath,"\Roaming\Mozilla\Firefox\Profiles")
$firefox_profiles_ini = -join($appdata_filepath,"\Roaming\Mozilla\Firefox\profiles.ini")
$firefox_installs_ini = -join($appdata_filepath,"\Roaming\Mozilla\Firefox\installs.ini")

#############
#BASE Script#
#############
Write-Host "Starting script..."
Write-Host "***Remember to run WingetInstallCaller first!***"

#creates browser bookmarks directory
Write-Host "Backing up browser bookmarks..."
New-Item -Path $backup_folder_name -Name $browser_bookmark_backup_title -ItemType directory
New-Item -Path $browser_bookmark_backup_folder -Name "Profiles" -ItemType directory

#saves new computer and user names as a .txt file
Write-Host "Saving hostname and username..."
$computer_name | Out-File $computer_name_filename 
$users_name | Out-File $username_filename

#exports all winget packages to an official .json file and logs non-winget packages to the errors log .txt file
Write-Host "Exporting winget packages..."
winget export -o $winget_package_file --include-versions --accept-source-agreements | Out-File $winget_errors_log_file  

#Copies relevant browser files
Write-Host "Backing up browser files..."
Copy-Item $edge_bookmarks -Destination $edge_bookmarks_rename
Copy-Item $chrome_bookmarks -Destination $chrome_bookmarks_rename
Copy-Item $firefox_profiles_ini -Destination $browser_bookmark_backup_folder
Copy-Item $firefox_installs_ini -Destination $browser_bookmark_backup_folder
robocopy $firefox_profiles $profiles_folder * /e /r:1 /COPYALL

Write-Host "The script has finished running!"