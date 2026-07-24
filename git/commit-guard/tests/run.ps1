Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$git = (Get-Command git).Source
$gitDirectory = Split-Path $git
$candidates = @(
    (Join-Path $gitDirectory "..\bin\sh.exe"),
    (Join-Path $gitDirectory "..\usr\bin\sh.exe"),
    (Join-Path $gitDirectory "sh.exe")
)
$shell = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $shell) {
    throw "Could not find Git's bundled sh.exe."
}

foreach ($test in @("test-pre-commit.sh", "test-live.sh")) {
    & $shell (Join-Path $PSScriptRoot $test)
    if ($LASTEXITCODE -ne 0) {
        throw "$test failed."
    }
}
