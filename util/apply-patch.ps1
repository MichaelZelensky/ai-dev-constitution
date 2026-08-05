param(
    [string]$Patch = "util\llm.patch"
)

$ErrorActionPreference = "Stop"

function ReadBlock {
    param(
        [string[]]$Lines,
        [ref]$Current
    )
    $block = @()
    while (
        $Current.Value -lt $Lines.Count -and
        $Lines[$Current.Value] -notmatch "^(diff|insert|delete|new|remove|rename)\b"
    ) {
        $block += $Lines[$Current.Value]
        $Current.Value++
    }
    return $block
}

function GetBeforeLines {
    param(
        [string[]]$File,
        [int]$Start
    )
    if ($Start -le 1) {
        return @()
    }
    return $File[0..($Start - 2)]
}

function GetAfterLines {
    param(
        [string[]]$File,
        [int]$End
    )
    if ($End -ge $File.Count) {
        return @()
    }
    return $File[$End..($File.Count - 1)]
}

$operations = (Get-Content -LiteralPath $Patch -Raw) -replace "`r", ""
$lines = $operations -split "`n"
$current = 0

while ($current -lt $lines.Count) {
    while ($current -lt $lines.Count -and [string]::IsNullOrWhiteSpace($lines[$current])) {
        $current++
    }
    if ($current -ge $lines.Count) {
        break
    }

    $header = $lines[$current]

    if ($header -match "^diff (.+)$") {
        $path = $Matches[1]
        $current++
        $range = $lines[$current]
        $current++
        $rangeParts = $range.Split("-")
        $start = [int]$rangeParts[0]
        $end = [int]$rangeParts[1]
        $replacement = ReadBlock -Lines $lines -Current ([ref]$current)
        $file = Get-Content -LiteralPath $path
        $before = GetBeforeLines -File $file -Start $start
        $after = GetAfterLines -File $file -End $end
        @($before + $replacement + $after) | Set-Content -LiteralPath $path
    }
    elseif ($header -match "^insert (.+)$") {
        $path = $Matches[1]
        $current++
        $line = [int]$lines[$current]
        $current++
        $insert = ReadBlock -Lines $lines -Current ([ref]$current)
        $file = Get-Content -LiteralPath $path
        $before = if ($line -gt 0) { $file[0..($line - 1)] } else { @() }
        $after = if ($line -lt $file.Count) { $file[$line..($file.Count - 1)] } else { @() }
        @($before + $insert + $after) | Set-Content -LiteralPath $path
    }
    elseif ($header -match "^delete (.+)$") {
        $path = $Matches[1]
        $current++
        $range = $lines[$current]
        $current++
        $rangeParts = $range.Split("-")
        $start = [int]$rangeParts[0]
        $end = [int]$rangeParts[1]
        $file = Get-Content -LiteralPath $path
        $before = GetBeforeLines -File $file -Start $start
        $after = GetAfterLines -File $file -End $end
        @($before + $after) | Set-Content -LiteralPath $path
    }
    elseif ($header -match "^new (.+)$") {
        $path = $Matches[1]
        $current++
        $content = ReadBlock -Lines $lines -Current ([ref]$current)
        $content | Set-Content -LiteralPath $path
    }
    elseif ($header -match "^remove (.+)$") {
        Remove-Item -LiteralPath $Matches[1]
        $current++
    }
    elseif ($header -match "^rename (.+) -> (.+)$") {
        Move-Item -LiteralPath $Matches[1] -Destination $Matches[2]
        $current++
    }
    else {
        throw "Unknown operation: $header"
    }
}

Write-Host "Done."