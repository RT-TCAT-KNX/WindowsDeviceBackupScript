#Comments like this

Write-Host "Starting script..."

#variables
#TODO throw error if drive not connected
$computer_name = $env:COMPUTERNAME
$users_name = $env:UserName
$app_data_filepath = -join("C:\Users\",$users_name,"AppData")
$backup_folder_name = -join("D:\",$computer_name,"\")
$username_filename = -join($backup_folder_name,"username.txt")
$winget_filename = -join($backup_folder_name,$computer_name,"_Installed_Packages.txt")

function File-Explorer-Copy {
$oc = New-Object -ComObject Shell.Application
$user_folder_filepath = -join("C:\Users\",$users_name)
$c_file_op_folder = $oc.NameSpace($user_folder_filepath)
$c_target_folder = $c_file_op_folder.ParseName("AppData")
$c_target_folder.Verbs() | %{ if ($_.Name -eq '&Copy') { $_.DoIt() } }
}

function File-Explorer-Paste {
$op = New-Object -ComObject Shell.Application
$drive_folder_filepath = "D:\"
$p_file_op_folder = $op.NameSpace($drive_folder_filepath)
$p_target_folder = $p_file_op_folder.ParseName($computer_name)
$p_target_folder.Verbs() | %{ if ($_.Name -like '*p*s*t*') { $_.DoIt() } } #Seems like Paste doesn't work here
}

New-Item -Path D:\ -Name $computer_name -ItemType directory
winget list | Out-File $winget_filename
Write-Host $users_name | Out-File $username_filename
File-Explorer-Copy
File-Explorer-Paste
Write-Host "The script has run successfully!"

#TODO check IF filesizes are too big
#ELSE, throw error list other apps