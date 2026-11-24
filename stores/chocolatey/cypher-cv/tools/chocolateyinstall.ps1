$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exe = Join-Path $toolsDir 'cypher-cv.exe'

Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName -FileFullPath $exe `
  -Url64bit 'https://github.com/kencypher56/cypher-releases/releases/download/cypher-cv-v1.0.0/CypherCV-1.0.0.exe' -Checksum64 '52c4f5234ab73040f4ba4ebf583317b4489d7203275a9373c2082871e205e7da' -ChecksumType64 'sha256'
Set-Content -Path "$exe.gui" -Value ''
