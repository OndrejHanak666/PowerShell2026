# aliasy.ps1
$json = Join-Path $PSScriptRoot 'aliasy.json'
$xml  = Join-Path $PSScriptRoot 'aliasy.xml'

# 1. Vytvoření aliasů
Set-Alias -Name np -Value notepad.exe
Set-Alias -Name ct -Value control.exe
Write-Host "Vytvořeno:" -ForegroundColor Cyan
Get-Alias np, ct

# 2. Záloha do JSON
Get-Alias np, ct |
    Select-Object Name, Definition |
    ConvertTo-Json |
    Set-Content -Path $json -Encoding UTF8

# 3. Záloha do XML
Get-Alias np, ct |
    Select-Object Name, Definition |
    Export-Clixml -Path $xml

# 4. Smazání aliasů
Remove-Item Alias:np, Alias:ct
Write-Host "`nPo smazání (nemělo by nic vypsat):" -ForegroundColor Cyan
Get-Alias np, ct -ErrorAction SilentlyContinue

# 5. Obnovení z JSON
Get-Content $json -Raw |
    ConvertFrom-Json |
    ForEach-Object { Set-Alias -Name $_.Name -Value $_.Definition }
Write-Host "`nObnoveno z JSON:" -ForegroundColor Cyan
Get-Alias np, ct

# 6. Opětovné smazání
Remove-Item Alias:np, Alias:ct
Write-Host "`nPo druhém smazání (nemělo by nic vypsat):" -ForegroundColor Cyan
Get-Alias np, ct -ErrorAction SilentlyContinue

# 7. Obnovení z XML
Import-Clixml -Path $xml |
    ForEach-Object { Set-Alias -Name $_.Name -Value $_.Definition }
Write-Host "`nObnoveno z XML:" -ForegroundColor Cyan
Get-Alias np, ct