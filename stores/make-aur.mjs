#!/usr/bin/env node
// Writes an AUR package (PKGBUILD, .SRCINFO, LICENSE.txt) for the AppImage in
// one release. The package installs the AppImage unchanged in /opt, plus a
// command, a menu entry and an icon taken from inside the AppImage.
//
//   node stores/make-aur.mjs cypher-music-v2.141 [--out dir] [--release release.json]
//
// Writes nothing, and says why, for a release without an AppImage or an app
// missing from stores/apps.json.

import { readFileSync, writeFileSync, mkdirSync, copyFileSync } from 'node:fs';
import { createHash } from 'node:crypto';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { parseTag, pickFiles } from './make-manifests.mjs';

const HERE = dirname(fileURLToPath(import.meta.url));
const LICENSE = join(HERE, '..', 'LICENSE.txt');
const MAINTAINER = 'Muhammad Waleed Amjad (Kencypher) <kencypher56 at gmail dot com>';

const sh = s => `"${String(s).replace(/(["\\$`])/g, '\\$1')}"`; // a bash double-quoted string

export function aurPackage(cfg, release, files, licenseSha) {
  const { slug, version } = parseTag(release.tag_name);
  const app = cfg.apps[slug];
  if (!app) return { skip: `${slug} is not in stores/apps.json` };
  const img = files.appimage;
  if (!img) return { skip: `${release.tag_name} has no AppImage` };
  const pkgname = `${slug}-appimage`;
  const url = `${cfg.site}/projects/${slug}`;
  const desc = app.short.replace(/\.$/, '');

  const pkgbuild = `# Maintainer: ${MAINTAINER}
pkgname=${pkgname}
_name=${slug}
_appimage=${img.file}
pkgver=${version}
pkgrel=1
pkgdesc=${sh(desc)}
arch=('x86_64')
url=${sh(url)}
license=('LicenseRef-Cypher-Store')
depends=('fuse2')
provides=("\${_name}")
conflicts=("\${_name}")
options=('!strip' '!debug')
noextract=("\${_appimage}")
source=("\${_appimage}::https://github.com/${cfg.repo}/releases/download/\${_name}-v\${pkgver}/\${_appimage}"
        'LICENSE.txt')
sha256sums=('${img.sha256}'
            '${licenseSha}')

prepare() {
  chmod +x "\${_appimage}"
  ./"\${_appimage}" --appimage-extract '*.desktop' >/dev/null
  local desk icon
  desk=$(find squashfs-root -maxdepth 1 -name '*.desktop' | head -n1)
  icon=$(sed -n 's/^Icon=//p' "\${desk}" | head -n1)
  ./"\${_appimage}" --appimage-extract "\${icon}.png" >/dev/null
  # electron-builder links this icon to the one under usr/share/icons.
  if [ -L "squashfs-root/\${icon}.png" ]; then
    ./"\${_appimage}" --appimage-extract "$(readlink "squashfs-root/\${icon}.png")" >/dev/null
  fi
  # Point the menu entry at the command this package installs.
  sed -E -e "s|^Exec=[^ ]+|Exec=/usr/bin/\${_name}|" -e "s|^Icon=.*|Icon=\${_name}|" \\
    -e '/^X-AppImage-/d' "\${desk}" > "\${_name}.desktop"
  cp -L "squashfs-root/\${icon}.png" "\${_name}.png"
}

package() {
  install -Dm755 "\${_appimage}" "\${pkgdir}/opt/\${_name}/\${_name}.AppImage"
  install -dm755 "\${pkgdir}/usr/bin"
  ln -s "/opt/\${_name}/\${_name}.AppImage" "\${pkgdir}/usr/bin/\${_name}"
  install -Dm644 "\${_name}.desktop" "\${pkgdir}/usr/share/applications/\${_name}.desktop"
  install -Dm644 "\${_name}.png" "\${pkgdir}/usr/share/pixmaps/\${_name}.png"
  install -Dm644 LICENSE.txt "\${pkgdir}/usr/share/licenses/\${pkgname}/LICENSE"
}
`;

  const srcinfo = `pkgbase = ${pkgname}
\tpkgdesc = ${desc}
\tpkgver = ${version}
\tpkgrel = 1
\turl = ${url}
\tarch = x86_64
\tlicense = LicenseRef-Cypher-Store
\tdepends = fuse2
\tprovides = ${slug}
\tconflicts = ${slug}
\tnoextract = ${img.file}
\toptions = !strip
\toptions = !debug
\tsource = ${img.file}::${img.url}
\tsource = LICENSE.txt
\tsha256sums = ${img.sha256}
\tsha256sums = ${licenseSha}

pkgname = ${pkgname}
`;
  return { pkgname, files: { PKGBUILD: pkgbuild, '.SRCINFO': srcinfo } };
}

async function main(argv) {
  const tag = argv.find(a => !a.startsWith('--'));
  const opt = name => { const i = argv.indexOf(name); return i >= 0 ? argv[i + 1] : undefined; };
  if (!tag) throw new Error('Usage: make-aur.mjs <tag> [--out dir] [--release release.json]');
  const cfg = JSON.parse(readFileSync(join(HERE, 'apps.json'), 'utf8'));
  let release;
  if (opt('--release')) release = JSON.parse(readFileSync(opt('--release'), 'utf8'));
  else {
    const headers = { Accept: 'application/vnd.github+json', 'User-Agent': 'cypher-store-aur' };
    if (process.env.GITHUB_TOKEN) headers.Authorization = `Bearer ${process.env.GITHUB_TOKEN}`;
    const res = await fetch(`https://api.github.com/repos/${cfg.repo}/releases/tags/${encodeURIComponent(tag)}`, { headers });
    if (!res.ok) throw new Error(`Release ${tag}: HTTP ${res.status}`);
    release = await res.json();
  }
  if (release.draft || release.prerelease) return console.log(`Skipped ${tag}: draft or pre-release`);
  const licenseSha = createHash('sha256').update(readFileSync(LICENSE)).digest('hex');
  const out = aurPackage(cfg, release, await pickFiles(release), licenseSha);
  if (out.skip) return console.log(`Skipped ${tag}: ${out.skip}`);
  const dir = join(opt('--out') || 'aur-out', out.pkgname);
  mkdirSync(dir, { recursive: true });
  for (const [name, text] of Object.entries(out.files)) writeFileSync(join(dir, name), text);
  copyFileSync(LICENSE, join(dir, 'LICENSE.txt'));
  console.log(`${out.pkgname}: ${dir}`);
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  main(process.argv.slice(2)).catch(e => { console.error(e.message); process.exit(1); });
}
