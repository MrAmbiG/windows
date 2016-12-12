Function Get-File($initialDirectory)
{
<#
.SYNOPSIS
    Browse and select a file

.DESCRIPTION
    This will open up a pop up dialog box and lets you choose a file. You can use this
    with your other scripts.
    If you want to limit the type of file that one can choose then uncomment the $OpenFileDialog.filter = "TXT (*.txt)| *.txt"
    and replace the TXT & txt with the extention of the type of file that you want.

.NOTES
    File Name      : Get-File.ps1
    Author         : gajendra d ambi
    Prerequisite   : PowerShell V4+, windows 7+.
    Copyright      - None

.EXAMPLE
    $file = Get-File(c:/tmp) #will open a pop up, lets you select a file and that will be declared as the value of $file.

.LINK
    Script posted over:
    https://github.com/mrambig/vmware
    http://www.workingsysadmin.com/open-file-dialog-box-in-powershell/
#>
#Start of Script
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null    
$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.initialDirectory = $initialDirectory
#$OpenFileDialog.filter = "TXT (*.txt) | *.txt"
$OpenFileDialog.ShowDialog() | Out-Null
$file = $OpenFileDialog.filename
} #End of script