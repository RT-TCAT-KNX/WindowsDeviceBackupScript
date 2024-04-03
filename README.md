# WindowsDeviceBackupScripts
Powershell scripts to backup a windows device before making major changes (such as feature updates, Windows reinstalls, or InTune implementations) and then restore some of the software/settings after the changes.

This script was designed for InTune implemementation

## How the scripts work

There are basically 5 functions of the script:
1. Export and import all winget packages
2. List all non-winget packages
3. Log all winget setup for future reference
4. Back up browser data that is ***not*** imported when the user signs in
5. Log hostname and username for future reference

## Running the Scripts

### Prerequisites
Ensure that you have administrator accesss for the devices that this script will be run on, otherwise the scripts will not run correctly

Additionally, this script was designed for uploading to and downloading from an external drive.
### Download scripts and preparing external drive
Download the latest .zip from the releases tab, and then extract the scripts to your drive.

Formatting the drive to NTFS is also recommended for additional speed and stability

### Instructions
1. Connect the drive to the device you want to back up
2. Run 1OldComputerCopy.bat as administrator
3. Open the 1OldComputerDELETE folder in the C:\ drive
4. Run OC_WingetInstallCallerfyCopy.bat as administrator
5. Run PreChangeBackup.bat as administrator
6. Make the desired changes to the device or change devices
7. Connect the drive to the new device
8. Run 2NewComputerCopy.bat as administrator
9. Open the 2NewComputerDELETE folder in the C:\ drive
10. Run NC_WingetInstallCallerfyCopy.bat as administrator
11. Run PreChangeBackup.bat as administrator