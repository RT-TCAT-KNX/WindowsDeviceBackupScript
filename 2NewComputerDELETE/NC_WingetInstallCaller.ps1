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

Write-Host "Starting script..."
Confirm-Folder-Path

###########
#VARIABLES#
###########
$new_computer_name = $env:COMPUTERNAME
$new_username = $env:UserName
$remember_path_file = "C:\backup_folder_location.txt"
$new_computer_name_filename = -join($backup_folder_name,"\","new_computer_name.txt")
$new_username_filename = -join($backup_folder_name,"\","new_username.txt")
$appdata_filepath = -join("C:\Users\",$new_username,"\AppData")
$winget_install_log = -join($backup_folder_name,"\new-winget-install-log.txt")

#############
#BASE Script#
#############
Write-Host "Saving hostname, username, and backup folder filepath..."

#saves new computer and user names as a .txt file
$new_computer_name | Out-File $new_computer_name_filename 
$new_username | Out-File $new_username_filename

#used by next script to remember file path
$backup_folder_name | Out-File $remember_path_file

#runs the latest version of "winget-install" from GitHub and logs all installation output to a .txt file
#NOTE -- THIS PART HAS TO RUN LAST. Otherwise things after it will fail if winget is already installed or something
Write-Host "Running winget-install..."
irm asheroto.com/winget | iex | Out-File $winget_install_log


Write-Host "The script has finished running!"