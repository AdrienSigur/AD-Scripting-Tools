Get-Process | Where-Object {$_.Handles  -lt 150}
