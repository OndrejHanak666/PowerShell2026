foreach ($c in [System.ConsoleColor].GetEnumValues()) {
    $name = $c.ToString().PadRight(16)
    Write-Host $name -NoNewline
    Write-Host $name -NoNewline -ForegroundColor $c
    Write-Host $name -BackgroundColor $c
}