
$OUprincipal ="OU=PARIS"

$CsvPath="User.csv"

$domainRoot = (Get-AdDomain).DistinguishedName

$dnsRoot = (Get-AdDomain).dnsRoot

$defaultPassword = "Root1234@"

$securePassword = ConvertTo-SecureString $defaultPassword -AsPlainText -Force 

$users = Import-Csv $CsvPath -Delimiter "," 


foreach($user in $users){

    
  $SamName = "$($user.Prenom)"

    $SamLastName = "$($user.Nom)"

    $SamAccountName = $SamName.tolower().Substring(0,1)+"."+$SamLastName.tolower()

    

    $UserCreation = @{
        Path = "OU=$($user.SousOu),$OUPrincipal,$domainRoot"
        Name = "$($user.Prenom)"
        SamAccountName = $SamAccountName
        UserPrincipalName = "${SamAccountName}@$dnsRoot"
        ChangePasswordAtLogon = $true
        Department =  "$($user.SousOU)"
        EmailAddress  = "${SamAccountName}@$dnsRoot"
        AccountPassword = $securePassword
        Enabled = $true
     }
     
    New-AdUser @UserCreation

     Write-host "$($User.Prenom) is success and created" -ForegroundColor Green 
 }