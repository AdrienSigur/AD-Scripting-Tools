<#
.SYNOPSIS
    Crée des utilisateurs AD en masse à partir d'un CSV.
.DESCRIPTION
    Importe une liste d'utilisateurs, génère un SamAccountName normalisé 
    et crée les comptes dans l'OU spécifiée. Gère les erreurs de création.
.PARAMETER CsvPath
    Chemin vers le fichier CSV source.
#>



function New-AdUserCsv{
  [CmdletBinding()]
  param(
      [Parameter(Mandatory=$true)]
      [String]$OUPrincipal,

      [Parameter(Mandatory=$true)]
      [String]$CsvPath ,

      [Parameter(Mandatory=$true)]
      [String]$DefaultPasswd
  )

if (-not $CsvPath){
  Write-Warning "Error Csv Path is incorrect you should take a good one"
  return
}



$users = Import-Csv $CsvPath -Delimiter ","  
$domainRoot = (Get-AdDomain).DistinguishedName
$dnsRoot = (Get-AdDomain).dnsRoot
$securePassword = ConvertTo-SecureString $defaultPasswd -AsPlainText -Force 


foreach($user in $users){


    
  if ([string]::IsNullOrWhiteSpace($user.Prenom) -or [string]::IsNullOrWhiteSpace($user.Nom)) {
      Write-Warning "Utilisateur ignoré (Nom ou Prénom manquant) : $($user | Out-String)"
      continue 
  }

    $SamName = "$($user.Prenom)"
    $SamLastName = "$($user.Nom)"
    $SamAccountName = $SamName.tolower().Substring(0,1)+"."+$SamLastName.tolower()
   
    
    try {

    $UserCreation = @{

        Path = "OU=$($user.SousOu),$OUPrincipal,$domainRoot"
        Name = "$($user.Prenom) + ${$user.Name}"
        SamAccountName = $SamAccountName
        UserPrincipalName = "${SamAccountName}@$dnsRoot"
        ChangePasswordAtLogon = $true
        Department =  "$($user.SousOU)"
        EmailAddress  = "${SamAccountName}@$dnsRoot"
        AccountPassword = $securePassword
        Enabled = $true
        ErrorAction = "Stop"
     }
     
    New-AdUser @UserCreation

     Write-host "$($user.Prenom) is success and created" -ForegroundColor Green 
    }catch{
      Write-host "$($user.Prenom) already exist" -ForegroundColor Red 
    }
    
    }
}