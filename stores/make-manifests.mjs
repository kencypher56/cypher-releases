#!/usr/bin/env node
// Turns one GitHub release into store-ready files: WinGet manifests, a
// Chocolatey package and a per-format checklist. Reads only; it never
// touches the release or its files.
//
//   node stores/make-manifests.mjs cypher-music-v2.141 [--out dir] [--release release.json]
//
// An app missing from stores/apps.json, a draft or a pre-release is skipped
// with listed=false, so apps nobody listed (Cypher HR, for one) never leave.
// Under GitHub Actions the result also goes to $GITHUB_OUTPUT.

import { readFileSync, writeFileSync, mkdirSync, appendFileSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const HERE = dirname(fileURLToPath(import.meta.url));
const WINGET_SCHEMA = '1.12.0';
// Inno Setup's documented switches (jrsoftware.org/ishelp, topics setupcmdline and uninstcmdline).
const INNO_SETUP_SILENT = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-';
const INNO_UNINSTALL_SILENT = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART';

export function parseTag(tag) {
  const m = /^(.+)-v(\d[0-9A-Za-z.]*)$/.exec(tag || '');
  if (!m) throw new Error(`Not a release tag of the form <app>-v<version>: ${tag}`);
  return { slug: m[1], version: m[2] };
}

const KINDS = [['exe', /\.exe$/i], ['appimage', /\.AppImage$/], ['apk', /\.apk$/i]];

/** The release's exe, AppImage and apk, each with its SHA-256. */
export async function pickFiles(release, fetchText = defaultFetchText) {
  const files = {};
  for (const [kind, re] of KINDS) {
    const hits = release.assets.filter(a => re.test(a.name));
    if (hits.length > 1) throw new Error(`${release.tag_name} has ${hits.length} ${kind} files; expected one`);
    if (!hits.length) continue;
    const a = hits[0];
    let sha = /^sha256:([0-9a-f]{64})$/i.exec(a.digest || '')?.[1];
    if (!sha) {
      // Older uploads carry no digest; use the .sha256 file published beside it.
      const side = release.assets.find(s => s.name === a.name + '.sha256');
      if (!side) throw new Error(`${a.name} has neither a GitHub digest nor a .sha256 file`);
      sha = /\b([0-9a-f]{64})\b/i.exec(await fetchText(side.browser_download_url))?.[1];
      if (!sha) throw new Error(`${side.name} holds no SHA-256`);
    }
    files[kind] = { file: a.name, url: a.browser_download_url, sha256: sha.toLowerCase(), size: a.size };
  }
  return files;
}

const q = s => JSON.stringify(String(s)); // a JSON string is a valid YAML double-quoted scalar
const xml = s => String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
const ps = s => String(s).replace(/'/g, "''"); // inside a PowerShell single-quoted string

export function wingetFiles(cfg, app, slug, version, exe, release) {
  const id = app.wingetId;
  const dir = join('winget', 'manifests', id[0].toLowerCase(), ...id.split('.'), version);
  const head = kind => `# yaml-language-server: $schema=https://aka.ms/winget-manifest.${kind}.${WINGET_SCHEMA}.schema.json\n\n` +
    `PackageIdentifier: ${id}\nPackageVersion: ${version}\n`;
  const tail = type => `ManifestType: ${type}\nManifestVersion: ${WINGET_SCHEMA}\n`;

  const installer = app.exe.type === 'inno'
    ? 'InstallerType: inno\nScope: machine\nElevationRequirement: elevatesSelf\nUpgradeBehavior: install\n'
    : `InstallerType: portable\nCommands:\n- ${app.exe.command}\n`;

  return {
    [join(dir, `${id}.yaml`)]: head('version') + 'DefaultLocale: en-US\n' + tail('version'),
    [join(dir, `${id}.installer.yaml`)]: head('installer') + 'MinimumOSVersion: 10.0.0.0\n' + installer +
      `Installers:\n- Architecture: x64\n  InstallerUrl: ${exe.url}\n  InstallerSha256: ${exe.sha256.toUpperCase()}\n` + tail('installer'),
    [join(dir, `${id}.locale.en-US.yaml`)]: head('defaultLocale') +
      `PackageLocale: en-US\nPublisher: ${q(cfg.publisher)}\nPublisherUrl: ${cfg.publisherUrl}\nPublisherSupportUrl: ${cfg.supportUrl}\n` +
      `Author: ${q(cfg.publisher)}\nPackageName: ${q(app.name)}\nPackageUrl: ${cfg.site}/projects/${slug}\n` +
      `License: ${q(cfg.license)}\nLicenseUrl: ${cfg.licenseUrl}\nCopyright: ${q(cfg.copyright)}\n` +
      `ShortDescription: ${q(app.short)}\nDescription: ${q(app.description)}\n` +
      `Tags:\n${app.tags.slice(0, 16).map(t => `- ${t}`).join('\n')}\nReleaseNotesUrl: ${release.html_url}\n` + tail('defaultLocale')
  };
}

export function chocolateyFiles(cfg, app, slug, version, exe, release) {
  const id = app.chocoId;
  const dir = join('chocolatey', id);
  const nuspec = `<?xml version="1.0" encoding="utf-8"?>
<package xmlns="http://schemas.microsoft.com/packaging/2015/06/nuspec.xsd">
  <metadata>
    <id>${xml(id)}</id>
    <version>${xml(version)}</version>
    <packageSourceUrl>https://github.com/${cfg.repo}/tree/master/stores</packageSourceUrl>
    <owners>${xml(cfg.publisher)}</owners>
    <title>${xml(app.name)}</title>
    <authors>${xml(cfg.publisher)}</authors>
    <projectUrl>${xml(`${cfg.site}/projects/${slug}`)}</projectUrl>
    <iconUrl>${xml(`${cfg.site}/img/icons/${slug}-256.png`)}</iconUrl>
    <copyright>${xml(cfg.copyright)}</copyright>
    <licenseUrl>${xml(cfg.licenseUrl)}</licenseUrl>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <bugTrackerUrl>${xml(cfg.supportUrl)}</bugTrackerUrl>
    <tags>${xml([id, ...app.tags].join(' '))}</tags>
    <summary>${xml(app.short)}</summary>
    <description>${xml(app.description)}</description>
    <releaseNotes>${xml(release.html_url)}</releaseNotes>
  </metadata>
  <files>
    <file src="tools\\**" target="tools" />
  </files>
</package>
`;
  const out = { [join(dir, `${id}.nuspec`)]: nuspec };
  if (app.exe.type === 'inno') {
    out[join(dir, 'tools', 'chocolateyinstall.ps1')] = `$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = '${ps(exe.url)}'
  checksum64     = '${exe.sha256}'
  checksumType64 = 'sha256'
  softwareName   = '${ps(app.exe.arpName)}*'
  silentArgs     = '${INNO_SETUP_SILENT}'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
`;
    out[join(dir, 'tools', 'chocolateyuninstall.ps1')] = `$ErrorActionPreference = 'Stop'

[array]$key = Get-UninstallRegistryKey -SoftwareName '${ps(app.exe.arpName)}*'

if ($key.Count -eq 1) {
  Uninstall-ChocolateyPackage -PackageName $env:ChocolateyPackageName -FileType 'exe' \`
    -SilentArgs '${INNO_UNINSTALL_SILENT}' -ValidExitCodes @(0) \`
    -File $key[0].UninstallString.Trim('"')
} elseif ($key.Count -eq 0) {
  Write-Warning "$env:ChocolateyPackageName has already been uninstalled by other means."
} else {
  Write-Warning "$($key.Count) installs match '${ps(app.exe.arpName)}*'; none was removed. Uninstall it from Settings > Apps."
}
`;
  } else {
    // A portable exe: Chocolatey shims it, and the .gui file marks it as a windowed app.
    out[join(dir, 'tools', 'chocolateyinstall.ps1')] = `$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exe = Join-Path $toolsDir '${ps(app.exe.command)}.exe'

Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName -FileFullPath $exe \`
  -Url64bit '${ps(exe.url)}' -Checksum64 '${exe.sha256}' -ChecksumType64 'sha256'
Set-Content -Path "$exe.gui" -Value ''
`;
  }
  return out;
}

const STORES = {
  exe: ['WinGet (pull request to microsoft/winget-pkgs)', 'Chocolatey community repository', 'Uptodown (Windows, upload in the Developers Console)', 'SourceForge'],
  appimage: ['SourceForge', 'Flathub and Snap Store: not packaged (they need their own formats)'],
  apk: ['Uptodown (Android)', 'Huawei AppGallery', 'Samsung Galaxy Store', 'Aptoide']
};

function summary(app, version, release, files) {
  const lines = [`## ${app.name} ${version}`, '', `Release: ${release.html_url}`, ''];
  if (files.exe && app.exe?.hold) lines.push(`**Windows stores on hold:** ${app.exe.hold}`, '');
  for (const kind of Object.keys(STORES)) {
    const f = files[kind];
    if (!f) continue;
    lines.push(`### ${kind}: \`${f.file}\``, '', `- URL: ${f.url}`, `- SHA-256: \`${f.sha256}\``, '- Stores to update:');
    for (const s of STORES[kind]) lines.push(`  - ${s}`);
    lines.push('');
  }
  return lines.join('\n');
}

/** Everything one release produces, as { listed, reason?, info, files: {path: text} }. */
export async function build(cfg, release, fetchText) {
  const { slug, version } = parseTag(release.tag_name);
  const app = cfg.apps[slug];
  const info = { listed: false, slug, version, tag: release.tag_name };
  if (!app) return { ...info, reason: `${slug} is not in stores/apps.json`, files: {} };
  if (release.draft || release.prerelease) return { ...info, reason: 'draft or pre-release', files: {} };

  const found = await pickFiles(release, fetchText);
  const out = { 'summary.md': summary(app, version, release, found) };
  if (found.exe && app.exe) {
    Object.assign(out, wingetFiles(cfg, app, slug, version, found.exe, release));
    Object.assign(out, chocolateyFiles(cfg, app, slug, version, found.exe, release));
  }
  // A held exe still gets its files, for review, but no store job runs for it.
  const send = found.exe && !app.exe?.hold;
  const result = {
    listed: true, slug, version, tag: release.tag_name, name: app.name,
    exe: !!found.exe, appimage: !!found.appimage, apk: !!found.apk,
    wingetId: (send && app.wingetId) || '', chocoId: (send && app.chocoId) || '', exeHold: !!(found.exe && !send),
    sourceforge: app.sourceforge || '', files: found
  };
  out['formats.json'] = JSON.stringify(result, null, 2) + '\n';
  return { ...result, files: out };
}

async function defaultFetchText(url) {
  const res = await fetch(url, { headers: { 'User-Agent': 'cypher-store-manifests' } });
  if (!res.ok) throw new Error(`${url}: HTTP ${res.status}`);
  return res.text();
}

async function fetchRelease(repo, tag) {
  const headers = { Accept: 'application/vnd.github+json', 'User-Agent': 'cypher-store-manifests' };
  if (process.env.GITHUB_TOKEN) headers.Authorization = `Bearer ${process.env.GITHUB_TOKEN}`;
  const res = await fetch(`https://api.github.com/repos/${repo}/releases/tags/${encodeURIComponent(tag)}`, { headers });
  if (!res.ok) throw new Error(`Release ${tag}: HTTP ${res.status}`);
  return res.json();
}

async function main(argv) {
  const tag = argv.find(a => !a.startsWith('--'));
  const opt = name => { const i = argv.indexOf(name); return i >= 0 ? argv[i + 1] : undefined; };
  if (!tag) throw new Error('Usage: make-manifests.mjs <tag> [--out dir] [--release release.json]');
  const cfg = JSON.parse(readFileSync(join(HERE, 'apps.json'), 'utf8'));
  const release = opt('--release') ? JSON.parse(readFileSync(opt('--release'), 'utf8')) : await fetchRelease(cfg.repo, tag);
  if (release.tag_name !== tag) throw new Error(`Asked for ${tag}, got ${release.tag_name}`);

  const result = await build(cfg, release);
  const outDir = opt('--out') || 'store-out';
  for (const [rel, text] of Object.entries(result.files)) {
    mkdirSync(dirname(join(outDir, rel)), { recursive: true });
    writeFileSync(join(outDir, rel), text);
  }
  const keys = ['listed', 'slug', 'version', 'tag', 'name', 'exe', 'appimage', 'apk', 'wingetId', 'chocoId', 'exeHold', 'sourceforge'];
  if (process.env.GITHUB_OUTPUT) appendFileSync(process.env.GITHUB_OUTPUT, keys.map(k => `${k}=${result[k] ?? ''}`).join('\n') + '\n');
  console.log(result.listed ? `${result.name} ${result.version}: ${Object.keys(result.files).length} files in ${outDir}` : `Skipped ${tag}: ${result.reason}`);
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  main(process.argv.slice(2)).catch(e => { console.error(e.message); process.exit(1); });
}
