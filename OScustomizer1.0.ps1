#####AIO-VM-settings#######################
#Rescan Disks                             #
#Rename Disks                             #
#initialize raw disks                     #
#resize all disks                         #
#assign z as drive letter to Cd ROM       #
#Enable Remote Desktop(+config firewall)  #
#Disable Firewall                         #
#Change Computer Description              #
#Change Computer name                     #
#install product key                      #
#update vm's dns                           #
#activate product key                     #
#change primary DNS suffix                #
#Set timezone                             #
#update hostfile                          #
#restart computer to apply changes        #
#Script Type : PowerShell                 #
###########################################
#DNS
$dns1 = "x.x.x.x"
$dns2 = "y.y.y.y"
$dns3 = "z.z.z.z"
$dns = "$dns1", "$dns2", $dns3

#Setting Variables
$CompName = Read-Host "Enter Computer's Name"
$suffix = Read-Host "Enter Primary DNS suffix"
$timezone = Read-Host "Type the timezone. example:Pacific Standard Time"
$PK = Read-Host "Paste The Product Key"
$HostFileEntries = ""
$vmDescription = "MyComputer"

#If CD rom drive letters isn't Z then change it to Z (usefull with custom images)
(gwmi Win32_cdromdrive).drive | %{$a = mountvol $_ /l;mountvol $_ /d;$a = $a.Trim();mountvol z: $a}

#VM Disk Names
$vm_c = "System/WebClient"
$vm_d = "Data/VM"
$vm_e = "Inventory"
$vm_f = "SSO"

#update vm DNS
$Interface = Get-WmiObject Win32_NetworkAdapterConfiguration
Write-Host "$(Get-Date -format T):Registering DNS $dns for $server" -ForegroundColor Green
$Interface.SetDNSServerSearchOrder($dns)

#Update Product Key
slmgr.vbs -ipk $PK

#Append entries to C:\Windows\System32\Drivers\etc\hosts
Add-Content C:\Windows\System32\Drivers\etc\hosts "`r`n$HostFileEntries"

#Rescan Disks
Write-Host "Rescanning Disks"
"rescan" | diskpart

#Initialize Disks if they are raw are not initialized
Write-Host "Finding Raw disks if any and then initialize, assign drive letter and format" -foregroundcolor Yellow
Get-Disk |
Where partitionstyle -eq 'raw' |
Initialize-Disk -PassThru |
New-Partition -AssignDriveLetter -UseMaximumSize |
Format-Volume -FileSystem NTFS -Confirm:$false

#Rename VM Disks
#Rename VM C Drive
$drivec = [wmi]"Win32_logicaldisk='C:'"
$drivec.VolumeName = $vm_c
$drivec.Put()
Write-Host "Renamed C Drive to $vm_c on VM" -foregroundcolor Green

#Rename VM D Drive
$drived = [wmi]"Win32_logicaldisk='D:'"
$drived.VolumeName = $vm_d
$drived.Put()
Write-Host "Renamed D Drive to $vm_d on VM" -foregroundcolor Green

#Rename VM E Drive
$drivee = [wmi]"Win32_logicaldisk='E:'"
$drivee.VolumeName = $vm_e
$drivee.Put()
Write-Host "Renamed E Drive to $vm_e on VM" -foregroundcolor Green

#Rename VM F Drive
$drivef = [wmi]"Win32_logicaldisk='F:'"
$drivef.VolumeName = $vm_f
$drivef.Put()
Write-Host "Renamed F Drive to $vm_f on VM" -foregroundcolor Green

#Resize all drives(just in case)
$MaxSize = (Get-PartitionSupportedSize -DriveLetter c).sizeMax
Resize-Partition -DriveLetter c -Size $MaxSize
$MaxSize = (Get-PartitionSupportedSize -DriveLetter D).sizeMax
Resize-Partition -DriveLetter D -Size $MaxSize
$MaxSize = (Get-PartitionSupportedSize -DriveLetter E).sizeMax
Resize-Partition -DriveLetter E -Size $MaxSize
$MaxSize = (Get-PartitionSupportedSize -DriveLetter F).sizeMax
Resize-Partition -DriveLetter F -Size $MaxSize

#Enable Remote Desktop and Adjust firewall for the same
Set-RemoteDesktopConfig -Enable -ConfigureFirewall
Write-Host "Enabled the Remote Desktop on VM and adjusted the firewall accordingly" -foregroundcolor Green

#Disable Firewall
Get-NetFirewallProfile | Set-NetFirewallProfile -Enabled False
Write-Host "Disabled the Firewall on VM" -foregroundcolor Green

#Change VM's Description
$x = Get-CimInstance Win32_OperatingSystem -Property Description
$x.Description = "$vmDescription"
Set-CimInstance -CimInstance $x -PassThru
Write-Host "Change the Description of the VM" -foregroundcolor Green

#Activate The Product Key
slmgr.vbs -ato

function Set-PrimaryDnsSuffix {
    param ([string] $Suffix)
   
    #http://poshcode.org/2958
    $ComputerNamePhysicalDnsDomain = 6
   
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    namespace ComputerSystem {
        public class Identification {
            [DllImport("kernel32.dll", CharSet = CharSet.Auto)]
            static extern bool SetComputerNameEx(int NameType, string lpBuffer);
           
            public static bool SetPrimaryDnsSuffix(string suffix) {
                try {
                    return SetComputerNameEx($ComputerNamePhysicalDnsDomain, suffix);
                }
                catch (Exception) {
                    return false;
                }
            }
        }
    }
"@
    [ComputerSystem.Identification]::SetPrimaryDnsSuffix($Suffix)
}

#Rename the Computer
Write-Host "Renaming the computer to $CompName" -foregroundcolor Green
Rename-Computer $CompName

#now set the primary dns suffix
Set-PrimaryDnsSuffix $suffix

function Set-TimeZone {
  [CmdletBinding(SupportsShouldProcess = $True)]
  param(
    [Parameter(ValueFromPipeline = $False, ValueFromPipelineByPropertyName = $True, Mandatory = $False)]
    [ValidateSet("Dateline Standard Time","UTC-11","Hawaiian Standard Time","Alaskan Standard Time","Pacific Standard Time (Mexico)","Pacific Standard Time","US Mountain Standard Time","Mountain Standard Time (Mexico)","Mountain Standard Time","Central America Standard Time","Central Standard Time","Central Standard Time (Mexico)","Canada Central Standard Time","SA Pacific Standard Time","Eastern Standard Time","US Eastern Standard Time","Venezuela Standard Time","Paraguay Standard Time","Atlantic Standard Time","Central Brazilian Standard Time","SA Western Standard Time","Pacific SA Standard Time","Newfoundland Standard Time","E. South America Standard Time","Argentina Standard Time","SA Eastern Standard Time","Greenland Standard Time","Montevideo Standard Time","Bahia Standard Time","UTC-02","Mid-Atlantic Standard Time","Azores Standard Time","Cape Verde Standard Time","Morocco Standard Time","UTC","GMT Standard Time","Greenwich Standard Time","W. Europe Standard Time","Central Europe Standard Time","Romance Standard Time","Central European Standard Time","W. Central Africa Standard Time","Namibia Standard Time","Jordan Standard Time","GTB Standard Time","Middle East Standard Time","Egypt Standard Time","Syria Standard Time","E. Europe Standard Time","South Africa Standard Time","FLE Standard Time","Turkey Standard Time","Israel Standard Time","Arabic Standard Time","Kaliningrad Standard Time","Arab Standard Time","E. Africa Standard Time","Iran Standard Time","Arabian Standard Time","Azerbaijan Standard Time","Russian Standard Time","Mauritius Standard Time","Georgian Standard Time","Caucasus Standard Time","Afghanistan Standard Time","Pakistan Standard Time","West Asia Standard Time","India Standard Time","Sri Lanka Standard Time","Nepal Standard Time","Central Asia Standard Time","Bangladesh Standard Time","Ekaterinburg Standard Time","Myanmar Standard Time","SE Asia Standard Time","N. Central Asia Standard Time","China Standard Time","North Asia Standard Time","Singapore Standard Time","W. Australia Standard Time","Taipei Standard Time","Ulaanbaatar Standard Time","North Asia East Standard Time","Tokyo Standard Time","Korea Standard Time","Cen. Australia Standard Time","AUS Central Standard Time","E. Australia Standard Time","AUS Eastern Standard Time","West Pacific Standard Time","Tasmania Standard Time","Yakutsk Standard Time","Central Pacific Standard Time","Vladivostok Standard Time","New Zealand Standard Time","UTC+12","Fiji Standard Time","Magadan Standard Time","Tonga Standard Time","Samoa Standard Time")]
    [ValidateNotNullOrEmpty()]
    [string]$TimeZone = "Eastern Standard Time"
  )

  $process = New-Object System.Diagnostics.Process
  $process.StartInfo.WindowStyle = "Hidden"
  $process.StartInfo.FileName = "tzutil.exe"
  $process.StartInfo.Arguments = "/s `"$TimeZone`""
  $process.Start() | Out-Null
} # end function Set-TimeZone

#set the timezone
Set-TimeZone $timezone

#Reboot the Computer for the changes to take effect
Restart-Computer

#End of Script
