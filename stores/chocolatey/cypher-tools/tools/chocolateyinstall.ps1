$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/kencypher56/cypher-releases/releases/download/cypher-tools-v1.1.0/CypherTools-Setup-1.1.0.exe'
  checksum64     = '4b79978b7c237d20d0e306fbe142f3e6810ca19e10406f8965af772b1dc642de'
  checksumType64 = 'sha256'
  softwareName   = 'Cypher Tools*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
