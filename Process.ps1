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

$ramTotal = $os.TotalVisibleMemorySize * 1KB   # Converti en bytes
$ramFree  = $os.FreePhysicalMemory     * 1KB
$ramUsedPercent = [math]::Round((($ramTotal - $ramFree) / $ramTotal) * 100, 2)

# -----------------------------
# Affichage
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

Show-Loading -Label "Cpu used" -Value $cpuLoad
Show-Loading -Label "Ram Used" -Value $ramUsedPercent



Get-NetIPConfiguration  -DestinationPrefix "0.0.0.0/0" |
    Where-Object {
        $_.IPv4DefaultGateway -ne $null -and
        $_.InterfaceAlias -notmatch "Virtual|VM|vEthernet|Loopback|Pseudo"
    } | Select-Object -First 1 -Property InterfaceAlias,IPv4Address,IPv4DefaultGateway 