$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/kencypher56/cypher-releases/releases/download/cypher-contacts-v1.18/CypherContacts-Setup-1.18.exe'
  checksum64     = '5fb18e86a11e6f85a36713747b538030cc53be75ca5135e682921afa95f0571c'
  checksumType64 = 'sha256'
  softwareName   = 'Cypher Contacts*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
