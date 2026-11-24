// node --test stores/make-manifests.test.mjs
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { parseTag, pickFiles, build } from './make-manifests.mjs';

const cfg = JSON.parse(readFileSync(new URL('./apps.json', import.meta.url), 'utf8'));
const SHA = 'ab'.repeat(32);
const asset = (name, digest = 'sha256:' + SHA) => ({ name, digest, size: 1, browser_download_url: `https://example.test/${name}` });
const release = (tag, names, extra = {}) => ({ tag_name: tag, html_url: `https://github.com/r/releases/tag/${tag}`, draft: false, prerelease: false, assets: names.map(n => asset(n)), ...extra });

test('parseTag splits slug and version', () => {
  assert.deepEqual(parseTag('cypher-music-v2.141'), { slug: 'cypher-music', version: '2.141' });
  assert.deepEqual(parseTag('cypher-printers-v1.0.0'), { slug: 'cypher-printers', version: '1.0.0' });
  assert.throws(() => parseTag('cypher-bot-voices-v'));
  assert.throws(() => parseTag(''));
});

test('apps nobody listed, drafts and pre-releases produce nothing', async () => {
  for (const r of [release('cypher-hr-v1.920.1004', ['CypherHR-Setup-1.920.1004.zip']),
                   release('cypher-bot-v1.131', ['CypherBot-1.131-x86_64.AppImage']),
                   release('cypher-music-v2.142', ['CypherMusic-Setup-2.142.exe'], { prerelease: true })]) {
    const out = await build(cfg, r);
    assert.equal(out.listed, false, r.tag_name);
    assert.deepEqual(out.files, {});
  }
});

test('an Inno installer gets WinGet manifests and a Chocolatey package with uninstall', async () => {
  const out = await build(cfg, release('cypher-music-v2.141', ['CypherMusic-Setup-2.141.exe', 'CypherMusic-Setup-2.141.exe.sha256', 'CypherMusic-2.141.apk', 'CypherMusic-2.141-x86_64.AppImage']));
  assert.equal(out.listed, true);
  assert.deepEqual([out.exe, out.appimage, out.apk], [true, true, true]);
  const inst = out.files['winget/manifests/k/Kencypher/CypherMusic/2.141/Kencypher.CypherMusic.installer.yaml'];
  assert.match(inst, /InstallerType: inno/);
  assert.match(inst, new RegExp(`InstallerSha256: ${SHA.toUpperCase()}`));
  assert.match(inst, /Architecture: x64/);
  assert.ok(out.files['chocolatey/cypher-music/tools/chocolateyuninstall.ps1']);
  assert.match(out.files['chocolatey/cypher-music/tools/chocolateyinstall.ps1'], /\/VERYSILENT \/SUPPRESSMSGBOXES \/NORESTART \/SP-/);
  assert.match(out.files['chocolatey/cypher-music/cypher-music.nuspec'], /<version>2\.141<\/version>/);
});

test('an exe on hold is prepared but sent to no Windows store', async () => {
  const out = await build(cfg, release('cypher-cv-v1.0.0', ['CypherCV-1.0.0.exe', 'CypherCV-1.0.0-x86_64.AppImage']));
  assert.equal(out.exe, true);
  assert.equal(out.wingetId, '');
  assert.equal(out.chocoId, '');
  assert.equal(out.exeHold, true);
  assert.match(out.files['summary.md'], /Windows stores on hold/);
  assert.ok(out.files['winget/manifests/k/Kencypher/CypherCV/1.0.0/Kencypher.CypherCV.installer.yaml']);
});

test('a portable exe gets a portable manifest and a shim, no uninstaller', async () => {
  const out = await build(cfg, release('cypher-cv-v1.0.0', ['CypherCV-1.0.0.exe', 'CypherCV-1.0.0-x86_64.AppImage']));
  const inst = out.files['winget/manifests/k/Kencypher/CypherCV/1.0.0/Kencypher.CypherCV.installer.yaml'];
  assert.match(inst, /InstallerType: portable\nCommands:\n- cypher-cv/);
  assert.equal(out.files['chocolatey/cypher-cv/tools/chocolateyuninstall.ps1'], undefined);
  assert.match(out.files['chocolatey/cypher-cv/tools/chocolateyinstall.ps1'], /\.gui/);
});

test('a Linux-only release prepares only the Linux stores', async () => {
  const out = await build(cfg, release('cypher-share-v3.1.1', ['CypherShare-3.1.1-x86_64.AppImage', 'CypherShare-3.1.1-x86_64.AppImage.sha256']));
  assert.deepEqual([out.exe, out.appimage, out.apk], [false, true, false]);
  assert.equal(out.wingetId, '');
  assert.ok(!Object.keys(out.files).some(f => f.startsWith('winget/') || f.startsWith('chocolatey/')));
});

test('a missing digest falls back to the .sha256 file, and an unusable one fails', async () => {
  const r = release('cypher-store-v1.4.1', ['CypherStore-1.4.1.apk', 'CypherStore-1.4.1.apk.sha256']);
  r.assets[0].digest = null;
  const files = await pickFiles(r, async () => `${'cd'.repeat(32)}  CypherStore-1.4.1.apk\n`);
  assert.equal(files.apk.sha256, 'cd'.repeat(32));
  await assert.rejects(pickFiles(r, async () => 'not found'), /holds no SHA-256/);
  r.assets.pop();
  await assert.rejects(pickFiles(r, async () => ''), /neither a GitHub digest/);
});

test('two files of one kind is an error, not a guess', async () => {
  await assert.rejects(build(cfg, release('cypher-tools-v1.1.0', ['A.exe', 'B.exe'])), /2 exe files/);
});
