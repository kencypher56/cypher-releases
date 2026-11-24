$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/kencypher56/cypher-releases/releases/download/cypher-share-v3.1.0/CypherShare-Setup-3.1.0.exe'
  checksum64     = '7a7d76a90d7ded51f9af7435d0de4fd5080dbf676475a9775e431363a907eb46'
  checksumType64 = 'sha256'
  softwareName   = 'CYPHER-SHARE*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
