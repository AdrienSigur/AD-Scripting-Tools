
$OUprincipal ="OU=PARIS"

$CsvPath="User.csv"

$domainRoot = (Get-AdDomain).DistinguishedName

$defaultPassword = "Root1234@"

$securePassword = ConvertTo-SecureString $defaultPassword -AsPlainText -Force 

$users = Import-Csv $CsvPath -Delimiter "," | Select-Object -First 1


 foreach($user in $users){



    $SamName = "$($user.Prenom)"
e
    $SamLastName = "$($user.Nom)"

    $SamAccountName = $a.tolower().Substring(0,1)+"."+$last.tolower()

    
      $SamAccountName = 

      $UserCreation = @{
        DistinguishedName = "OU=$($user.SousOu), $OUPrincipal , $domainRoot"
        Name = "$user.Prenom"
        SamAccountName = $SamAccountName
        AccountPassword = $securePassword

     }
     New-AdUser @UserCreation
 }