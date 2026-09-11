#!/usr/bin/env node
/* ═══════════════════════════════════════════════════════════════════════
 *  Compiles one setup.exe per app from the shared cypher-app.iss.
 *
 *      node installer/build-installers.js            all apps
 *      node installer/build-installers.js music      just that one
 *
 *  Reads apps.json, checks the APK is staged in dist/, then runs the Inno
 *  Setup compiler. AppIds are fixed per app, so a new version upgrades the
 *  previous install rather than appearing twice in Add/Remove Programs.
 * ═══════════════════════════════════════════════════════════════════════ */

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const HERE = __dirname;
const ROOT = path.join(HERE, '..');
const DIST = path.join(ROOT, 'dist');

const ISCC = [
  'C:\\Program Files (x86)\\Inno Setup 7\\ISCC.exe',
  'C:\\Program Files\\Inno Setup 7\\ISCC.exe',
  'C:\\Program Files (x86)\\Inno Setup 6\\ISCC.exe',
  'C:\\Program Files\\Inno Setup 6\\ISCC.exe'
].find(p => fs.existsSync(p));

if (!ISCC) {
  console.error('Inno Setup compiler not found. Install Inno Setup, then re-run.');
  process.exit(1);
}

const apps = JSON.parse(fs.readFileSync(path.join(HERE, 'apps.json'), 'utf8'));
const only = process.argv[2];
const targets = only ? apps.filter(a => a.key === only) : apps;

if (!targets.length) {
  console.error(`No app matching "${only}". Known: ${apps.map(a => a.key).join(', ')}`);
  process.exit(1);
}

let built = 0, skipped = 0, failed = 0;

for (const app of targets) {
  const apk = path.join(DIST, app.apk);
  if (!fs.existsSync(apk)) {
    console.log(`skip  ${app.name} — ${app.apk} is not in dist/ yet`);
    skipped++;
    continue;
  }

  const icon = path.join(HERE, 'assets', app.icon);
  const args = [
    `/DAppName=${app.name}`,
    `/DAppSlug=${app.slug}`,
    `/DAppVersion=${app.version}`,
    `/DAppId=${app.appId}`,
    `/DApkFile=${path.relative(HERE, apk)}`,
    ...(fs.existsSync(icon) ? [`/DIconFile=${path.relative(HERE, icon)}`] : []),
    'cypher-app.iss'
  ];

  process.stdout.write(`build ${app.name} ${app.version} ... `);
  const r = spawnSync(ISCC, args, { cwd: HERE, encoding: 'utf8' });

  if (r.status === 0) {
    const out = path.join(DIST, `${app.slug}-Setup-${app.version}.exe`);
    const mb = fs.existsSync(out) ? (fs.statSync(out).size / 1048576).toFixed(1) + ' MB' : '?';
    console.log(`ok  (${mb})`);
    built++;
  } else {
    console.log('FAILED');
    const msg = (r.stdout || '') + (r.stderr || '');
    console.log(msg.split('\n').filter(l => /error|Error/.test(l)).slice(0, 6).join('\n') || msg.slice(-600));
    failed++;
  }
}

console.log(`\n${built} built, ${skipped} skipped, ${failed} failed`);
process.exit(failed ? 1 : 0);
