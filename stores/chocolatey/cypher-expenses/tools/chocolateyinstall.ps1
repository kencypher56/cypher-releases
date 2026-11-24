$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/kencypher56/cypher-releases/releases/download/cypher-expenses-v3.11/CypherExpenses-Setup-3.11.exe'
  checksum64     = '6ec4ce8454c800c94fa64d1d4aa9799dece9cc0cb06013937554a9fad0a02b01'
  checksumType64 = 'sha256'
  softwareName   = 'Cypher Expenses*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
