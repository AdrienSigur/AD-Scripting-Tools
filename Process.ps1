Get-Process | Sort-Object -Property CPU -Descending  | Select-Object -First 5 

## Cpu process 


$totalCpu = 0 

Get-Process | ForEach-Object {
    $totalCpu += $_.CPU
}


$os = Get-CimInstance Win32_ComputerSystem
$ram = Get-CimInstance -ClassName CIM_OperatingSystem



$ramTotal = $os.TotalPhysicalMemory
$ramfree = $ram.FreePhysicalMemory
$UsedRam = [math]::Round((($ramTotal - $ramFree) / $ramTotal) * 100, 2)



Write-Host

Write-Host "Ram total used = $UsedRam"