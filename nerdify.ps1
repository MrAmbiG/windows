<#
.SYNOPSIS
    Replace alphabets with characters & numbers

.DESCRIPTION
    This will nerdify your document for no reason. Just for fun. Point to a text file and it will replace the alphabets with characters and numbers to nerdify it.

.NOTES
    File Name      : nerdify.ps1
    Author         : gajendra d ambi
    Prerequisite   : PowerShell V4+, windows 7+.
    Copyright      - None

.LINK
    Script posted over:
    https://github.com/mrambig/vmware
#>
#Start of Script
$dfile = Read-Host "path?"
if ((Get-Item $dfile) -is [System.IO.DirectoryInfo] -eq "True") {
Get-ChildItem $dfile
Write-Host "copy paste the name of the file(with extention) that you want nerdify" -ForegroundColor Black -BackgroundColor White
$file = Read-Host "?"
}

if ((Get-Item $dfile) -eq [System.IO.DirectoryInfo] -eq "False") { Get-ChildItem $file = $dfile }

$newfile = "nerdified.txt"
Copy-Item $file $newfile

$array = @(
, (" you ", " u ")
, (" your ", " ur ")
, (" are ", " r ")
, (" or ", " r ")
, (" we ", " v ")
, (" they ", " dey ")
, (" and ", " & ")
, (" be ", " b ")
, ("i", "!")
, ("e", "3")
, ("o", "0")
, ("l", "1")
, ("s", "5")
, ("a", "@")
)

foreach ($value in $array) { (gc $newfile) -replace $value[0], $value[1] | sc $newfile }