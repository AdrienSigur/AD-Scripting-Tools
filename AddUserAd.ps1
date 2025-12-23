<<<<<<< HEAD
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
=======

$OUprincipal ="OU=PARIS"

$CsvPath="User.csv"

$domainRoot = (Get-AdDomain).DistinguishedName

$dnsRoot = (Get-AdDomain).dnsRoot

$defaultPassword = "Root1234@"

$securePassword = ConvertTo-SecureString $defaultPassword -AsPlainText -Force 

$users = Import-Csv $CsvPath -Delimiter "," 
>>>>>>> cd14d9371c14593f2c621820b23c8dd0e585ac54


foreach($user in $users){

<<<<<<< HEAD

    
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
=======
    
  $SamName = "$($user.Prenom)"

    $SamLastName = "$($user.Nom)"

    $SamAccountName = $SamName.tolower().Substring(0,1)+"."+$SamLastName.tolower()


    $UserCreation = @{
        Path = "OU=$($user.SousOu),$OUPrincipal,$domainRoot"
        Name = "$($user.Prenom)"
>>>>>>> cd14d9371c14593f2c621820b23c8dd0e585ac54
        SamAccountName = $SamAccountName
        UserPrincipalName = "${SamAccountName}@$dnsRoot"
        ChangePasswordAtLogon = $true
        Department =  "$($user.SousOU)"
        EmailAddress  = "${SamAccountName}@$dnsRoot"
        AccountPassword = $securePassword
        Enabled = $true
<<<<<<< HEAD
        ErrorAction = "Stop"
=======
>>>>>>> cd14d9371c14593f2c621820b23c8dd0e585ac54
     }
     
    New-AdUser @UserCreation

<<<<<<< HEAD
     Write-host "$($user.Prenom) is success and created" -ForegroundColor Green 
    }catch{
      Write-host "$($user.Prenom) already exist" -ForegroundColor Red 
    }
    
    }
}
=======
     Write-host "$($User.Prenom) is success and created" -ForegroundColor Green 
 }
>>>>>>> cd14d9371c14593f2c621820b23c8dd0e585ac54
