
### ACTIVE DIRECTORY CHECK DOMAIN NAME ###

Try {
    $Domain = Get-ADDomain
    Write-Host "Communication with the Domain $($Domain.DNSRoot) : VALIDATE" -ForegroundColor Blue
} Catch {
    Write-Host "ERROR : Impossible to connect to the domain!" -ForegroundColor Red
}

### DISK VOLUMES ####

function DriveVolume {
    param (
        [Array]$Drive 
    )

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
        Write-Host ("{0,-9} = {1} %" -f $Label, $Value ) -ForegroundColor $color
}


    foreach ($Letter in $Drive) {

        $DriveContainer = Get-Volume -DriveLetter $letter -ErrorAction SilentlyContinue

    if (-not $DriveContainer) {
        Write-Host "Le volume $letter n'existe pas." -ForegroundColor DarkGray
        continue
    }

        $SizeRemaining = $DriveContainer.SizeRemaining
        $SizeMax = $DriveContainer.Size

        $Size = [math]::Round($SizeRemaining / 1GB , 2)
        $Pourcentage =  [math]::Round((($sizeMax - $SizeRemaining) / $SizeMax) * 100, 2)
        Write-host""
        Show-Loading -Label "Disk Used $letter" -Value $Pourcentage
        Write-Host "Volume $letter Remaining  $Size GB" -ForegroundColor Blue
        

    }

}

DriveVolume -Drive "C" , "E"
Write-host""
    

### SERVICES ####


$Services = "DNS", "Dhcp", "sshd" , "ntds" ,"WSearch"

Foreach ($S in $Services) {

    try {
          $Status = (Get-Service -Name $S -ErrorAction Stop)
          $Service = $Status.DisplayName

        If ($Status.Status -eq 'Running') {
            Write-Host "Service $S : $Service Online" -ForegroundColor Green
        }else{
            Write-Host "Service $S : $Service NOT RUNNING" -ForegroundColor Red
        }

    }catch{
            Write-Host "ERREUR : This service '$S' is unfound or does not exist." -ForegroundColor Yellow
    }
       
}     


write-host""



#### Gateway and ip addess in ipv4 ####

$iface = Get-NetRoute -DestinationPrefix "0.0.0.0/0" |
         Sort-Object RouteMetric |
         Select-Object -First 1

$ip = Get-NetIPAddress -InterfaceIndex $iface.InterfaceIndex -AddressFamily IPv4 |
      Select-Object  -ExpandProperty IPAddress

$gw = $iface.NextHop

Write-Host "IPv4 address : $ip" -ForegroundColor Blue
Write-Host "IPv4 gateway : $gw" -ForegroundColor Blue