$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exe = Join-Path $toolsDir 'cypher-printers.exe'

Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName -FileFullPath $exe `
  -Url64bit 'https://github.com/kencypher56/cypher-releases/releases/download/cypher-printers-v1.0.0/CypherPrinters-1.0.0.exe' -Checksum64 'bb5213e63f0ca6ef484313a4a6656c840d261c009d858b4750a4b23b386248e6' -ChecksumType64 'sha256'
Set-Content -Path "$exe.gui" -Value ''
