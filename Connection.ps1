param (
    [System.Object]$Ip ,
    [System.Object]$Dns 
    
)

$ip = Test-Connection $Ip -Quiet -Count 4

$DnsConnection = Test-Connection $Dns -Quiet -Count 4


if ($DnsConnection -and $Ip){
    Write-Host "Dns and ip  is functionnal connected"
}else{
    Write-Host "Dns is not working connected"
}

