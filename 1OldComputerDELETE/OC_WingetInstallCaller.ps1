###########
#VARIABLES#
###########
$computer_name = $env:COMPUTERNAME
$backup_folder_name = -join("D:\",$computer_name)
$winget_install_log = -join($backup_folder_name,"\old-winget-install-log.txt")

#############
#BASE Script#
#############
Write-Host "Starting script..."

New-Item -Path "D:\" -Name $computer_name -ItemType directory

#runs the latest version of "winget-install" from GitHub and logs all installation output to a .txt file
Write-Host "Running winget-install..."
irm asheroto.com/winget | iex | Out-File $winget_install_log

Write-Host "The script has finished running"