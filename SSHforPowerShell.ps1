#SSHforPowerShell
#MrAmbiG1 \ http://ambitech.blogspot.in/2015/06/ssh-for-powershell.html
#All credits to the maker of this module.
#set the C:\Users\<user>\Documents\WindowsPowerShell\Modules as a variable for the powershell.replace <user> with your username equivalent
$env:PSModulePath = $env:PSModulePath + ";C:\Users\<user>\Documents\WindowsPowerShell\Modules"
#download and install the SSH module
iex (New-Object Net.WebClient).DownloadString("https://gist.github.com/darkoperator/6152630/raw/c67de4f7cd780ba367cccbc2593f38d18ce6df89/instposhsshdev")
