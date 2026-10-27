$name = "PowerShell"
[int]$count = 5

"Vítejte v $name"     # vypíše: Vítejte v PowerShell
'Vítejte v $name'     # vypíše: Vítejte v $name

if ($count -gt 3) {
    Write-Host "Víc než tři"
}

for ($i = 0; $i -lt $count; $i++) {
    Write-Host $i
}

foreach ($service in Get-Service) {
    if ($service.Status -eq 'Running') { $service.Name }
}