$memberships = Import-Csv .\group_members.csv

foreach ($m in $memberships) {

    Add-ADGroupMember `
        -Identity $m.Group `
        -Members $m.User `
        -ErrorAction Stop

    Write-Host "Added $($m.User) to $($m.Group)"
}