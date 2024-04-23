::This script runs a PowerShell script of the same name in the same directory

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -Command "& {Start-Process PowerShell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dpn0.ps1""' -Verb RunAs}