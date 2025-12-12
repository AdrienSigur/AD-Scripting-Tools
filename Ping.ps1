Get-NetIPAddress | Where-Object {
    $_.InterfaceAlias -eq "Wi-Fi 4" -and
    $_.AddressFamily -eq "InterNetwork"
}