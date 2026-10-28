[CmdletBinding(SupportsShouldProcess)]
param(
    [ValidateSet('claude-code', 'codex', 'both')]
    [string]$Agent = 'both',
    [string]$ClaudeHome = $(if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }),
    [string]$CodexHome = $(if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' })
)
$ErrorActionPreference = 'Stop'
$encoding = [Text.UTF8Encoding]::new($false)
$source = Join-Path (Split-Path $PSScriptRoot -Parent) 'rules/collaboration.md'
$rules = [IO.File]::ReadAllText($source).TrimEnd()
$begin = '<!-- allenstu6311/Skills:begin -->'
$end = '<!-- allenstu6311/Skills:end -->'

function Save-ManagedFile([string]$Path, [string]$Content) {
    if (Test-Path -LiteralPath $Path) {
        if ([IO.File]::ReadAllText($Path) -ceq $Content) { Write-Output "Unchanged: $Path"; return }
    }
    if ($PSCmdlet.ShouldProcess($Path, 'Install shared collaboration rules')) {
        New-Item -ItemType Directory -Path (Split-Path $Path -Parent) -Force | Out-Null
        if (Test-Path -LiteralPath $Path) {
            Copy-Item -LiteralPath $Path -Destination ($Path + '.' + [guid]::NewGuid().ToString('N') + '.bak')
        }
        [IO.File]::WriteAllText($Path, $Content, $encoding)
        Write-Output "Updated: $Path"
    }
}

if ($Agent -in @('claude-code', 'both')) {
    Save-ManagedFile (Join-Path $ClaudeHome 'rules/allenstu-collaboration.md') ($rules + "`n")
}
if ($Agent -in @('codex', 'both')) {
    $override = Join-Path $CodexHome 'AGENTS.override.md'
    if ((Test-Path -LiteralPath $override) -and (Get-Item -LiteralPath $override).Length -gt 0) {
        throw "A global override exists at $override. Resolve it before installing Codex rules; it would take precedence over AGENTS.md."
    }
    $target = Join-Path $CodexHome 'AGENTS.md'
    $existing = if (Test-Path -LiteralPath $target) { [IO.File]::ReadAllText($target) } else { '' }
    $block = $begin + "`n" + $rules + "`n" + $end
    $pattern = '(?s)' + [regex]::Escape($begin) + '.*?' + [regex]::Escape($end)
    $begins = [regex]::Matches($existing, [regex]::Escape($begin)).Count
    $ends = [regex]::Matches($existing, [regex]::Escape($end)).Count
    if ($begins -ne $ends -or $begins -gt 1 -or ($begins -eq 1 -and -not [regex]::IsMatch($existing, $pattern))) {
        throw "Malformed or duplicate managed markers in $target. No Codex file was changed."
    }
    if ($begins -eq 1) {
        $content = [regex]::Replace($existing, $pattern, [Text.RegularExpressions.MatchEvaluator]{ param($match) $block })
    } elseif ($existing.Trim() -eq $rules.Trim()) {
        $content = $block + "`n"
    } else {
        $separator = if ($existing.Length -eq 0) { '' } elseif ($existing.EndsWith("`n`n")) { '' } elseif ($existing.EndsWith("`n")) { "`n" } else { "`n`n" }
        $content = $existing + $separator + $block + "`n"
    }
    Save-ManagedFile $target $content
}
