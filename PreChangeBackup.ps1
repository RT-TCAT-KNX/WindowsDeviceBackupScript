#Comments like this

Write-Host "Starting script..."

#variables
$host = Convert-String -InputObject hostname #it's trying to re-write the hostname
#throw error if drive not connected
cd D:\
$foldername = $env:COMPUTERNAME
New-Item -Name $foldername -ItemType directory
$winget_filename = $host + "_Installed_Packages.txt"
$user_data_filename = $host + "_UserData.txt"
$program_data_filename = $host + "_UserData.txt"
winget list | Out-File $winget_filename
#check IF filesizes are too big
#program data? -- FOR loop?
#user  data? -- FOR loop?
#ELSE, throw error list other apps