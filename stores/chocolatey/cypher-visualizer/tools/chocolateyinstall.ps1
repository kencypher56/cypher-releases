$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/kencypher56/cypher-releases/releases/download/cypher-visualizer-v1.1.0/CypherVisualizer-Setup-1.1.0.exe'
  checksum64     = '80651cfa3917d0cfe3e8ae2a8d45e9924e591b3cd07cda035191f340fdb7e1eb'
  checksumType64 = 'sha256'
  softwareName   = 'Cypher Visualizer*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
