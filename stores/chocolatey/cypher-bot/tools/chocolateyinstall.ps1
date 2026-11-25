$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/kencypher56/cypher-releases/releases/download/cypher-bot-v1.123/CypherBot-Setup-1.123.exe'
  checksum64     = 'a81a47dda0b14596393ce961276dd14c5796f255b2631ade648467904aecd945'
  checksumType64 = 'sha256'
  softwareName   = 'Cypher BOT*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
