#Activate Product Key                  #
#Check Activation                      #
#Compiled By: MrAmbiG                  #
########################################
#Get Product Key
$PK = Read-Host "Type/Paste The Product Key"

#Clear KMS Entry
#slmgr.vbs -ckms

#Remove Existing product Key
#slmgr.vbs -upk

#Update Product Key
slmgr.vbs -ipk $PK

#sleep for 10 seconds
Start-Sleep -s 10

#Activate The Product Key
slmgr.vbs -ato

#sleep for 10 seconds
Start-Sleep -s 10

# check Activation
set-executionpolicy unrestricted
Write-Host "Verifying Activation Status..."

$slmgrResult = cscript c:\windows\system32\slmgr.vbs /dli
[string]$licenseStatus = ($slmgrResult | select-string -pattern "^License Status:")
$licenseStatus = $LicenseStatus.Remove(0,16)

if ( $licenseStatus -match "Licensed") {
Write-Host "Activated"
$retryCount = 0
}
else {
Write-Host "Not Activated."
}
