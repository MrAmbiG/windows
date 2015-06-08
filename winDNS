######winDNS#############
#set DNS for windows    #
#by MrAmbiG1             #
#########################
$vmDNS1 = "1.1.1.1"
$vmDNS2 = "2.2.2.2"
$dns = "$vmDNS1", "$vmDNS2"

$Interface = Get-WmiObject Win32_NetworkAdapterConfiguration 
Write-Host "$(Get-Date -format T):Registering DNS $dns for $server" -ForegroundColor Green
$Interface.SetDNSServerSearchOrder($dns)
