param(
    [Parameter(ValueFromRemainingArguments)]
    [string[]]$Text
)

function Test-Palindrom {
    param([Parameter(Mandatory)][string]$Text)

    $normalizovanyText = $Text.ToLower().Normalize([Text.NormalizationForm]::FormD)
    $cistyText = $normalizovanyText -replace '[^\p{L}\p{Nd}]', ''

    $znaky = $cistyText.ToCharArray()
    [array]::Reverse($znaky)

    return ($cistyText -ceq (-join $znaky))
}

$vstupniText = $Text -join ' '

if ([string]::IsNullOrWhiteSpace($vstupniText)) {
    $vstupniText = Read-Host "Zadejte text"
}

if ([string]::IsNullOrWhiteSpace($vstupniText)) {
    Write-Error "Nebyl zadán žádný text."
    exit 1
}

$sMezerami = $vstupniText.Length
$bezMezer = ($vstupniText -replace '\s', '').Length
$bezDiakritiky = $vstupniText.ToLower().Normalize([Text.NormalizationForm]::FormD) -replace '\p{M}', ''
$samohlasky = ([regex]::Matches($bezDiakritiky, '[aeiouy]')).Count
$slova = ([regex]::Matches($vstupniText, '\S+')).Count
$jePalindrom = Test-Palindrom $vstupniText

Write-Host ""
Write-Host "Statistika textu:"
Write-Host "Znaků s mezerami: $sMezerami"
Write-Host "Znaků bez mezer:  $bezMezer"
Write-Host "Samohlásek:       $samohlasky"
Write-Host "Slov:             $slova"
Write-Host ""

if ($jePalindrom) {
    Write-Host "Text je palindrom." -ForegroundColor Green
}
else {
    Write-Host "Text NENÍ palindrom." -ForegroundColor Red
}
