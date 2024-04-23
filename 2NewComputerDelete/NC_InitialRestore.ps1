#asks user to type in backup folder path and confirms if it is correct
#then sets variables dependent upon path
function Confirm-Folder-Path {
    Do {
    $folder_response = Read-Host "Enter the path for this user's old computer backup folder (i.e. D:\NAME-LT, F:\PERSON-SURF, etc.)."
    $confirmation = Read-Host "You entered $folder_response. Is this correct? y/n: "
    }
    Until ($confirmation -eq "y" -and (Test-Path $folder_response))
	Set-Variable backup_folder_name -Scope Script -Value $folder_response
}

#pauses the script until a user inputs something. allows the other script to run between the two phases of this one
$message = "Click ok once you have successfully run the winget script."
Function pause ($message)
{
    # Check if running Powershell ISE
    if ($psISE) {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("$message")
    }
    else {
        Write-Host "$message" -ForegroundColor Yellow
        $x = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
}

$new_computer_name = $env:COMPUTERNAME
$remember_path_file = "C:\backup_folder_location.txt"
$new_computer_name_filename = -join($backup_folder_name,"\","new_computer_name.txt")

Write-Host "Starting script..."
Confirm-Folder-Path

#############
#BASE Script#
#############
Write-Host "Saving hostname and backup folder filepath..."

#saves new computer and user names as a .txt file
$new_computer_name | Out-File $new_computer_name_filename 

#used by next script to remember file path
$backup_folder_name | Out-File $remember_path_file

#Set-ExecutionPolicy RemoteSigned

pause

$new_username_file = -join($backup_folder_name,"\","new_username.txt")
#reads input from the last script via the .txt file
function Get-Username {
    Set-Variable new_username -Scope Script -Value (Get-Content -Path $new_username_file)
}

###########
#VARIABLES#  ### Add browser stuff again as params ### to be called as --options, if you will (silly Windows, calling it something else)
###########
$appdata_filepath = -join("C:\Users\",$new_username,"\AppData")

#browser bookmark variables 
$browser_bookmark_backup_title = "Browser Bookmarks"
$browser_bookmark_backup_folder = -join($backup_folder_name,"\",$browser_bookmark_backup_title)
$profiles = "Profiles"
$profiles_folder = -join($browser_bookmark_backup_folder,"\",$profiles)
$edge_bookmarks_rename = -join($appdata_filepath,"\Local\Microsoft\Edge\User Data\Default\Bookmarks")
$edge_bookmarks = -join($browser_bookmark_backup_folder,"\edge_Bookmarks")
$chrome_bookmarks_rename = -join($appdata_filepath,"\Local\Google\Chrome\User Data\Default\Bookmarks")
$chrome_bookmarks = -join($browser_bookmark_backup_folder,"\chrome_Bookmarks")
$chrome_user_data_backup = -join($backup_folder_name,"\Chrome User Data")
$chrome_user_data = -join($appdata_filepath,"\Local\Google\Chrome\User Data")
$firefox_profiles = -join($appdata_filepath,"\Roaming\Mozilla\Firefox\Profiles")
#$firefox_profile = -join()
$new_firefox_profiles_ini = -join($appdata_filepath,"\Roaming\Mozilla\Firefox\profiles.ini")
$new_firefox_installs_ini = -join($appdata_filepath,"\Roaming\Mozilla\Firefox\installs.ini")
$old_firefox_profiles_ini = -join($browser_bookmark_backup_folder,"\profiles.ini")
$old_firefox_installs_ini = -join($browser_bookmark_backup_folder,"\installs.ini")

#Deletes relevant browser files
#Write-Host "Restoring browser data..."
#Remove-Item -Path $edge_bookmarks_rename -Force
#Remove-Item -Path $chrome_bookmarks_rename -Force
#firefox functionality is not working yet
#Remove-Item -Path $new_firefox_installs_ini -Force
#Remove-Item -Path $new_firefox_profiles_ini -Force

#Copies relevant browser files
#Copy-Item -Force $edge_bookmarks -Destination $edge_bookmarks_rename
#Copy-Item -Force $chrome_bookmarks -Destination $chrome_bookmarks_rename
#firefox functionality is not working yet
#Copy-Item -Force $old_firefox_profiles_ini -Destination $new_firefox_profiles_ini
#Copy-Item -Force $old_firefox_installs_ini -Destination $new_firefox_installs_ini
#robocopy $profiles_folder $firefox_profiles /e /r:1 /COPYALL
#robocopy $chrome_user_data_backup $chrome_user_data /e /r:1 /COPYALL /MIR
#robocopy $chrome_user_data_backup $chrome_user_data /e /r:1 /COPYALL

#Set-ExecutionPolicy Restricted

Write-Host "The script has finished running!"