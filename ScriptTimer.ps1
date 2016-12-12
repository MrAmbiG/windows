$TimeStart = Get-Date #start time
$TimeEnd   = Get-Date #end time
$TimeTaken = $TimeEnd - $TimeStart #total time taken
$TimeStart #starting the timer
{} #scriptblock
$TimeEnd #stopping the timer
Write-Host "Time taken - $TimeTaken" -BackgroundColor White -ForegroundColor blue #total time taken