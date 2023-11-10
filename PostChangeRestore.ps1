Write-Host "Starting script..."

#variables
cd D:\
$foldername = $env:COMPUTERNAME
$winget_filename = $env:COMPUTERNAME + "_Installed_Packages.txt"

#for file in $winget_filename winget install $file

#$user_data_filename = $host + "_UserData.txt"
#$program_data_filename = $host + "_UserData.txt"
#check IF filesizes are too big
#program data? -- FOR loop?
#user  data? -- FOR loop?
#ELSE, throw error list other apps