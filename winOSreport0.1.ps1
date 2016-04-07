<#
.SYNOPSIS
    Gerate windows OS report
.DESCRIPTION
   An example report of your windows OS to get the information about CPU, MEMORY  etc.,
.NOTES
    File Name      : winOSreport0.1.ps1
    Author         : gajendra d ambi
    Prerequisite   : PowerShell V2 over Vista and upper.
    Copyright      - None
.LINK
    Script posted over:
    https://github.com/gajuambi/windows
#>

#style, table and some background color
$a = "<style>"
$a = $a + "BODY{background-color:#F0FFFF;}"
$a = $a + "TABLE{border-width: 5px;border-style: solid;border-color: Purple;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 10px;border-style: solid;border-color: black;background-color:LightSeaGreen}"
$a = $a + "TD{border-width: 1px;padding: 10px;border-style: solid;border-color: black;background-color:WhiteSmoke}"
$a = $a + "</style>"

#define file path
$path = "D:\"

#CPU
$cpuinfo = gwmi -Class Win32_Processor
$cpu = $cpuinfo | Select-Object Caption, @{Name="Core";Expression={$_.NumberOfCores}}, @{Name="Total Threads";Expression={$_.NumberOfLogicalProcessors}}, DeviceID, Manufacturer, MaxClockSpeed, SocketDesignation | ConvertTo-HTML -Fragment -PreContent '<p4> <font face="Algerian" size="9" color="DarkBlue"><p align="center"><u><b>HOST INFORMATION</b></u></font> </p4><p>      </p> <p3> <font color="#1A1B1C"><b>CPU<b></font> </p3>' | Out-String

#MEMORY
$meminfo = gwmi -Class Win32_PhysicalMemory
           #rename the header from Capacity to size
$mem = $meminfo | Select-Object @{Name="Size";Expression={$_.Capacity}}, Caption, DataWidth, Description | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="navy"><b>Memory<b></font> </p3>' | Out-String



#name of the pc
$name = hostname

#Host's name as the name of the report
$file = $($name + ".html")

#create a report from the html fragments
ConvertTo-HTML -head $a -body "$fqdn $cpu $mem" | Out-File $path\$file -Force

#move the file to the location of the script
mi $path\$file $PSScriptRoot\ -force

#open the report
ii $PSScriptRoot\$file
