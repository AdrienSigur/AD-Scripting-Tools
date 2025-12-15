$OrganizationUnits = @("Terrason" , "Paris" , "Dunkerque")

$DistinguishedName = "DC=Arasaka,DC=lab"

$SubUnits = @("Group" , "Computer" , "Compta" , "RH" , "Direction")


foreach ($OU in $OrganizationUnits) { 

    $list = @{
        Name = $OU
        path = $DistinguishedName
        ProtectedFromAccidentalDeletion = $false

    }

    $Exist = Get-ADOrganizationalUnit -Filter "Name -like '$OU'" -ErrorAction SilentlyContinue

    if ($Exist){
        Write-Host "This Organization $OU already exist " -Foreground Yellow
    }else{ 
        New-ADOrganizationalUnit @list

        Write-Host "Success Creation of $OU" -ForegroundColor Green

        Get-ADOrganizationalUnit -Filter "Name -like '$OU'"

    }


    foreach ($SubOu in $SubUnits) {

        $path = "OU=$OU,$DistinguishedName"

        $Sub = @{
            Name = $SubOu
            Path = $path
            ProtectedFromAccidentalDeletion = $false
        }

        New-ADOrganizationalUnit  @Sub
    }


}

