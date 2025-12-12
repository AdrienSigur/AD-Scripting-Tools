Get-Process | Sort-Object -Property CPU -Descending  | Select-Object -First 5 
# -----------------------------
# CPU usage total (en %)
# -----------------------------
$cpuLoad = (Get-Counter).CounterSamples |
    Where-Object { $_.Path -match "processeur\(_total\).*temps processeur" } |
    Select-Object -ExpandProperty CookedValue
$cpuLoad = [math]::Round($cpuLoad, 2)

# -----------------------------
# RAM usage (en %)
# -----------------------------
$os = Get-CimInstance Win32_OperatingSystem

$ramTotal = $os.TotalVisibleMemorySize * 1KB   
$ramFree  = $os.FreePhysicalMemory     * 1KB
$ramUsedPercent = [math]::Round((($ramTotal - $ramFree) / $ramTotal) * 100, 2)

# -----------------------------
# Affichage couleur
# -----------------------------
function Show-Loading {
    param (
        [string]$Label,
        [int]$Value
    )

    if ($Value -lt 60) {
        $color = "Green"
    }
    elseif ($Value -lt 85) {
        $color = "Yellow"
    }
    else {
        $color = "Red"
    }
    Write-Host ("{0,-9}= {1} %" -f $Label, $Value) -ForegroundColor $color
}

Write-Host""

# -----------------------------
# Cpu and Ram used 
# -----------------------------

Show-Loading -Label "Cpu used" -Value $cpuLoad
Show-Loading -Label "Ram Used" -Value $ramUsedPercent

Write-Host""


# -----------------------------
# IPV4 pc and IPV4 gateway 
# -----------------------------

$iface = Get-NetRoute -DestinationPrefix "0.0.0.0/0" |
         Sort-Object RouteMetric |
         Select-Object -First 1

$ip = Get-NetIPAddress -InterfaceIndex $iface.InterfaceIndex -AddressFamily IPv4 |
      Select-Object -ExpandProperty IPAddress

$gw = $iface.NextHop

Write-Host "IPv4 address : $ip" -ForegroundColor Blue
Write-Host "IPv4 gateway : $gw" -ForegroundColor Blue