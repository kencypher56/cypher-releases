$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/kencypher56/cypher-releases/releases/download/cypher-music-v2.141/CypherMusic-Setup-2.141.exe'
  checksum64     = '60b26aa955a184c2a3a897050e1685e64c3679b65d0d016d4e69ffdf7eca2f7e'
  checksumType64 = 'sha256'
  softwareName   = 'Cypher Music*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
