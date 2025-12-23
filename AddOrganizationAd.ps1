function New-ADOrganizationalUnitCsv{
  [CmdletBinding()]
  param(
      [Parameter(Mandatory=$true)]
      [String]$OUPrincipal,

      [Parameter(Mandatory=$true)]
      [String]$CsvPath 

  )

$CsvGroup = Import-Csv $CsvPath -Delimiter ","   

$DistinguishedName = (Get-AdDomain).DistinguishedName



foreach ($OU in $OUPrincipal) { 

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

    foreach ($SubOu in $CsvGroup) {

        $path = "OU=$OU,$DistinguishedName"
        $NameSubOrganizationunit = $SubOu.OU

        $Sub = @{
            Name = $NameSubOrganizationunit
            Path = $path
            ProtectedFromAccidentalDeletion = $false
        }

        New-ADOrganizationalUnit  @Sub
        Write-Host "Success Creation of $NameSubOrganizationunit under Principal Organization Unit $OU" -ForegroundColor Green
    }

}
}
