[CmdletBinding()]
param(
    [string]$Destination = (Join-Path $env:USERPROFILE ".git-hooks")
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Force -Path $Destination | Out-Null
Copy-Item -Force -LiteralPath (Join-Path $PSScriptRoot "pre-commit") -Destination $Destination
Copy-Item -Force -LiteralPath (Join-Path $PSScriptRoot "never-commit.txt") -Destination $Destination

$gitPath = $Destination.Replace("\", "/")
git config --global core.hooksPath $gitPath
if ($LASTEXITCODE -ne 0) {
    throw "Failed to configure core.hooksPath."
}

Write-Output "Installed global Git commit guard at $Destination"
