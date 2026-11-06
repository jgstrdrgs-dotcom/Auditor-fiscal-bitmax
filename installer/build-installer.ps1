param(
    [Parameter(Mandatory = $true)]
    [string]$AppExe,
    [string]$Makensis
)

$ErrorActionPreference = 'Stop'
$installerDir = $PSScriptRoot
$repoRoot = Split-Path -Parent $installerDir
$appPath = (Resolve-Path -LiteralPath $AppExe).Path
$scriptPath = Join-Path $installerDir 'auditor-fiscal-bitmax.nsi'
$outputDir = Join-Path $repoRoot 'artifacts'
$outputPath = Join-Path $outputDir 'Auditor Fiscal BITMAX Setup 2.6.17.exe'

if (-not $Makensis) {
    $candidate = Get-Command 'makensis.exe' -ErrorAction SilentlyContinue
    if ($candidate) {
        $Makensis = $candidate.Source
    } elseif ($env:NSISDIR -and (Test-Path -LiteralPath (Join-Path $env:NSISDIR 'makensis.exe'))) {
        $Makensis = Join-Path $env:NSISDIR 'makensis.exe'
    } else {
        $commonPaths = @(
            "$env:ProgramFiles\NSIS\makensis.exe",
            "${env:ProgramFiles(x86)}\NSIS\makensis.exe"
        )
        $Makensis = $commonPaths | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
    }
}

if (-not $Makensis -or -not (Test-Path -LiteralPath $Makensis)) {
    throw 'Não encontrei makensis.exe. Instale o NSIS 3 ou informe -Makensis com o caminho do compilador.'
}

New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
& $Makensis "/DAPP_BINARY=$appPath" "/DSETUP_OUTPUT=$outputPath" $scriptPath
if ($LASTEXITCODE -ne 0) {
    throw "O NSIS encerrou com código $LASTEXITCODE. O instalador não foi gerado."
}

$setup = Get-Item -LiteralPath $outputPath
$hash = (Get-FileHash -LiteralPath $outputPath -Algorithm SHA256).Hash.ToLowerInvariant()
Write-Output "Instalador: $($setup.FullName)"
Write-Output "Tamanho: $($setup.Length) bytes"
Write-Output "SHA-256: $hash"
