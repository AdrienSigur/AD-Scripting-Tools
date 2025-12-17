param (
        [Parameter(Mandatory)]
            [String]$Ou ,
            
        [Parameter(Mandatory)]
            [String]$Csv 
)

function GroupCreation{

    param (
        [string]$Ou,
        [String]$Csv
    )
   
    $CsvPath = $Csv

    $Group = Import-Csv $CsvPath -Delimiter "," 


    $OrganizationUnit = "$Ou"
    $RootResearch = "OU=$OrganizationUnit," + (Get-AdDomain).DistinguishedName

    try {

        $Exist = Get-ADOrganizationalUnit -Identity $RootResearch -ErrorAction Stop

    }catch{

        Write-Host "The Organization Unit $OU not existing" -ForegroundColor Yellow
        return
    }

    Write-Host "OU exists, CSV loaded"


foreach ($groups in $Group){

    if($Exist){

        $group = @{
            Name = $test
            SamAccountName = $test
            GroupCreation = $test
            GroupCategory = $test
            Description = $test
            Path = $test

        }

        write-host @group
    }



}
   
}

GroupCreation -Ou $Ou -Csv $Csv