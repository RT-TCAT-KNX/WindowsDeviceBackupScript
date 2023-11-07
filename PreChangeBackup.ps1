#Comments like this

Write-Host "Starting script..."

#variables
#TODO throw error if drive not connected
$folder_name = $env:COMPUTERNAME
New-Item -Path D:\ -Name $folder_name -ItemType directory
$winget_filename = -join("D:\",$folder_name,"\",$folder_name,"_Installed_Packages.txt")
winget list | Out-File $winget_filename
#$user_data_filename = $host + "_UserData.txt"
#$program_data_filename = $host + "_UserData.txt"
$directory = Get-Item .
$directory | Get-ChildItem | Measure-Object -Sum Length | Select-Object
#check IF filesizes are too big
#program data? -- FOR loop?
#user  data? -- FOR loop?
#ELSE, throw error list other apps