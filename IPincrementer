<#
.SYNOPSIS
    Increment IP addressed for your scripts
.DESCRIPTION
    This will use the split function of the powershell to split the ip addresses by . and then increments the last octet and joins them.
    This might come in handy if you want to perform a certain number of action on a range of ip addresses in a script.
    This is rather an adaptation of the ip incrementer script by LUCD who is a powercli and powershell guru and
    extremely active on vmware communities. All credits to him.
.NOTES
    File Name      : IPincrementer.ps1
    Author         : LUCD, gajendra d ambi
    Date           : Jan 2015
    Prerequisite   : PowerShell V2 over Vista and upper.
    Copyright      - None
.LINK
    Script posted over:
    https://github.com/gajuambi/windows
#>
#start of script

#let's get the 1st ip address
$host1 = Read-Host "type the 1st ip address"

#Then let us have the number of ip addresses that you want
$max = Read-Host "Maximum nubmer of ip addresses?"

#now split that ip address and retain the 1st 3 octets which will be fixed
$fixed = $host1.Split('.')[0..2]

#now let us have the last octet of the host's ip address
$last = [int]($host1.Split('.')[3])

#let us subtract 1 from the maximum number of IPs that we want since it counts from 0
$max_hosts = $max - 1

#now let us increment the $last octet with a +1 till we get $max_hosts of ip addresses
$hosts = 
$last..($last + $max_hosts) | %{
    [string]::Join('.',$fixed) + "." + $_
}

#now let us print the results to the screen
$hosts

#End of script
