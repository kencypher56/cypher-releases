$ErrorActionPreference = 'Stop'

[array]$key = Get-UninstallRegistryKey -SoftwareName 'Cypher Expenses*'

if ($key.Count -eq 1) {
  Uninstall-ChocolateyPackage -PackageName $env:ChocolateyPackageName -FileType 'exe' `
    -SilentArgs '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART' -ValidExitCodes @(0) `
    -File $key[0].UninstallString.Trim('"')
} elseif ($key.Count -eq 0) {
  Write-Warning "$env:ChocolateyPackageName has already been uninstalled by other means."
} else {
  Write-Warning "$($key.Count) installs match 'Cypher Expenses*'; none was removed. Uninstall it from Settings > Apps."
}
