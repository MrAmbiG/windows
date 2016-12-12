$vmHost = Get-VMHost -Name "esxName"

 

$portgoup = Get-VirtualPortGroup -Name "Management"

 

$nic = New-Object VMware.Vim.HostVirtualNicSpec

 

$distributedVirtualPort = New-Object VMware.Vim.DistributedVirtualSwitchPortConnection

$nic.distributedVirtualPort = $distributedVirtualPort

$nic.distributedVirtualPort.portgroupKey = $portgoup.key

$nic.distributedVirtualPort.switchUuid = $portgoup.VirtualSwitch.key

 

$nic.netStackInstanceKey = 'vmotion'

 

$ip = New-Object VMware.Vim.HostIpConfig

$ip.subnetMask = '255.255.255.0'

$ip.ipAddress = '192.168.0..10'

$ip.dhcp = $false

 

$ip.ipV6Config = New-Object VMware.Vim.HostIpConfigIpV6AddressConfiguration

$ip.ipV6Config.dhcpV6Enabled = $false

$ip.ipV6Config.autoConfigurationEnabled = $false

 

$ip.IpV6Config = $ipV6Config

$nic.Ip = $ip

 

$networkSystem = $vmHost.ExtensionData.configManager.NetworkSystem

$_this = Get-view -Id ($networkSystem.Type + "-" + $networkSystem.Value)

$_this.AddVirtualNic('', $nic)