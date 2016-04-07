####Hostfile##################
#add hostfile entries        #
#Script Type:Powershell      #
#MrAmbiG                     #
#ambitech.blogspot.in/2015/02/customizing-vms-and-their-specifics.html?     #
##############################
#paste your entries in between the "" below
$HostFileEntries = ""

#Append entries to C:\Windows\System32\Drivers\etc\hosts
Add-Content C:\Windows\System32\Drivers\etc\hosts "`r`n$HostFileEntries"
