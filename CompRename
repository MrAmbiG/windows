#####ComputerVariable#####
#Rename Computer         #
#Add Domain & Restart    #
# MrAmbiG                #
#ambitech.blogspot.in    #
##########################

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

#Setting Variables
$CompName = Read-Host "Enter Computer's Name"
$suffix = Read-Host "Enter Primary DNS suffix"

#Rename the Computer
Write-Host "Renaming the computer to $CompName" -foregroundcolor Green
Rename-Computer $CompName

#now set the primary dns suffix
Set-PrimaryDnsSuffix $suffix

#Reboot the Computer for the changes to take effect
Restart-Computer

#end of script
