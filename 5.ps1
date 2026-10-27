# text-statistika.ps1
param(
    [Parameter(Mandatory, ValueFromRemainingArguments)]
    [string[]]$Text
)

$text = $Text -join ' '

# Znaky s mezerami a bez mezer (bílé znaky)
$sMezerami = $text.Length
$bezMezer  = ($text -replace '\s', '').Length

# Samohlásky: základní písmeno po odstranění diakritiky (á -> a, ě -> e, ů -> u ...)
$bezDiakritiky = $text.ToLower().Normalize([Text.NormalizationForm]::FormD) -replace '\p{M}', ''
$samohlasky = ([regex]::Matches($bezDiakritiky, '[aeiouy]')).Count

# Slova: souvislé posloupnosti nebílých znaků
$slova = ([regex]::Matches($text, '\S+')).Count

Write-Host "Znaků s mezerami: $sMezerami"
Write-Host "Znaků bez mezer:  $bezMezer"
Write-Host "Samohlásek:       $samohlasky"
Write-Host "Slov:             $slova"