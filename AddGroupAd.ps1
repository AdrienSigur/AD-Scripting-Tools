
function GroupCreation{

    param (
        [string]$Ou,
        [String]$Csv 
    )
   
    $CsvPath = $Csv

    $CsvGroup = Import-Csv $CsvPath -Delimiter "," 

    $RootDN = "OU=$Ou," + (Get-AdDomain).DistinguishedName

    $RootOU = Get-ADOrganizationalUnit -Identity $RootDN -ErrorAction SilentlyContinue

    WRITE-Host $RootOU

    if (-not $RootOU) {
    Write-Host "The OU '$Ou' does not exist under this Domain Controller" -ForegroundColor Yellow
    return
    }

    $OuGroup = Get-ADOrganizationalUnit -SearchBase $RootOU.DistinguishedName -Filter "Name -like '*Group*'" -ErrorAction SilentlyContinue

    write-host $OuGroup

    if (-not $OuGroup) {
    Write-Host "The OU 'Group' does not exist under $Ou" -ForegroundColor Yellow
    return
    }


foreach ($Groups in $CsvGroup){


        $Group = @{
            Name = $($Groups.Name)
            SamAccountName = $($Groups.SamAccountName)
            GroupScope = $($groups.GroupScope)
            GroupCategory = $($Groups.GroupCategory)
            Description = $($Groups.Description)
            Path = $OuGroup.DistinguishedName

        }

        New-ADGroup @Group

        write-host "Creation du groupe $($Groups.name) dans l'OU $Ou" -ForegroundColor Green
    }



}
   
 GroupCreation -Ou "Paris" -Csv "Group.csv"







# New-ADGroup -Name "GS_Compta" -GroupScope Global -GroupCategory Security -Path "OU=PARIS,DC=arasaka,DC=lab"