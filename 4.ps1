# palindrom.ps1
function Test-Palindrom {
    param([Parameter(Mandatory)][string]$Text)

    # Rozložení znaků s diakritikou (á -> a + čárka), malá písmena
    $norm = $Text.ToLower().Normalize([Text.NormalizationForm]::FormD)

    # Odstranění všeho, co není písmeno nebo číslice (mezery, interpunkce, diakritika)
    $clean = $norm -replace '[^\p{L}\p{Nd}]', ''

    # Obrácený řetězec
    $chars = $clean.ToCharArray()
    [array]::Reverse($chars)
    $reversed = -join $chars

    return ($clean -ceq $reversed)
}

# Testovací věty
$testy = @(
    "Jelenovi pivo nelej",
    "Kobyla má malý bok",
    "Kupředu udeř puk",
    "Dal kopat Ota poklad",
    "Toto není palindrom"
)

foreach ($t in $testy) {
    $vysledek = if (Test-Palindrom $t) { "je palindrom" } else { "NENÍ palindrom" }
    Write-Host ("{0,-25} -> {1}" -f $t, $vysledek)
}

# Vlastní vstup od uživatele
Write-Host ""
$vstup = Read-Host "Zadejte vlastní text (Enter = konec)"
if ($vstup) {
    if (Test-Palindrom $vstup) { Write-Host "Text je palindrom." -ForegroundColor Green }
    else { Write-Host "Text NENÍ palindrom." -ForegroundColor Red }
}