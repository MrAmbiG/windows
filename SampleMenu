<#
.SYNOPSIS
    A sample loop menu
.DESCRIPTION
    A sample loop menu. characteristics of this menu are
    loops till a valid choice/entry is made
    you can include many submenus
.NOTES
    File Name      : SampleMenu.ps1
    Author         : gajendra d ambi
    Date           : February 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of the script
 do {
 do {
     Write-Host "`nSampleMenu" -BackgroundColor White -ForegroundColor Black #heading of the menu here `n represents new line
     Write-Host "
     A. Cluster
     B. Host
     C. vSwitch
     D. dvSwitch" #options to choose from
   
     Write-Host "
     Y. Datastores
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
     switch ($choice) 
     {
     "A" { Write-Host you chose A }
     "B" { Write-Host you chose B }
     "C" { Write-Host you chose C }
     "D" { Write-Host you chose D }
     "Y" { Write-Host you chose Y }
     }
    } until ( $choice -match "Z" )

