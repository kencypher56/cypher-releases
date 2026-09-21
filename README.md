# Cypher — Releases

Downloads for the Cypher applications, by [Kencypher](https://github.com/kencypher56).

**This repository holds releases only.** There is no application source here —
the builds are produced elsewhere and published to the Releases page.

> Full feature lists, screenshots and setup guides for every app live on the
> site: **https://cypherstore.vercel.app**

---

## The apps

| App | Android | Windows | Linux | What it is |
|---|:--:|:--:|:--:|---|
| **Cypher Music** | ✅ | ✅ | ✅ | Offline music and video library, a downloader for hundreds of sites, and a vocal/instrumental splitter |
| **Cypher BOT** | ✅ | ✅ | ✅ | Turns a Reddit thread into a narrated short video with character voices |
| **Cypher Contacts** | ✅ | ✅ | ✅ | Contacts manager that exports and imports in eleven formats |
| **Cypher Expenses** | ✅ | ✅ | ✅ | Expense and income tracker that produces a real PDF statement |
| **Cypher Share** | ✅ | ✅ | ✅ | Sends files and whole folders between your computers and phones over your own network, at full speed |
| **Cypher HR** | — | ✅ | ✅ | Desktop HR, attendance and payroll, reading a ZKTeco terminal |

Cypher HR has no Android build: it is a desktop workflow backed by a
PostgreSQL database.


---

## Installing

### Android (`.apk`)

Android blocks installs from outside the Play Store by default. When you open
the downloaded file, allow installs from your browser or file manager, then
open the APK again.

Every release is signed with the same key, so an update installs over the top
and keeps your existing data.

### Windows (`.exe`)

Run the installer and follow the wizard. Windows may warn that the publisher is
unrecognised, because these installers are not code-signed — choose
**More info → Run anyway**.

### Linux (`.AppImage`)

```bash
chmod +x CypherMusic-2.121.AppImage
./CypherMusic-2.121.AppImage
```

An AppImage needs no installation and no root. If it refuses to start on a
recent distribution, try `--no-sandbox`.

---

## Verifying a download

Each release lists SHA-256 checksums. On Windows:

```powershell
Get-FileHash .\CypherMusic-2.121.apk -Algorithm SHA256
```

On Linux or macOS:

```bash
sha256sum CypherMusic-2.121.apk
```

---

## Reporting a problem

Open an issue here with the app name, its version, and your OS or Android
version. Crash reports are more useful with the steps that led to them.

---

## Licence

**Free to use. Not open source. Not yours to republish.**

Every application here was written by **Kencypher** (Muhammad Waleed Amjad),
sole author and sole copyright holder. All rights reserved.

You may run it on as many of your own machines as you like, use it for
anything including commercial work, and hand an unmodified copy to a friend
free of charge.

You may **not**, without written permission:

- Sell it, rent it, or charge for access to it
- Re-upload, mirror or redistribute it anywhere — no app store, no download
  site, no file host, no torrent, no repackaged installer
- Publish it under another name or claim authorship of it
- Rebrand it: change the name, icon, artwork or credits
- Decompile it, reverse-engineer it, or extract its models and assets
- Remove the author's name from it

**This is enforced.** Re-uploading this software, repackaging it, stripping the
author's name from it or passing it off as your own is copyright infringement —
protected without registration under the Berne Convention — and is pursued with
DMCA takedowns to the host, CDN, app store and search engine, platform reports
for impersonation, and legal proceedings where the infringement is commercial,
repeated, or involves falsely claiming authorship. Permission ends automatically
the moment these terms are broken.

Asking first is free, and the answer is usually yes: **kencypher56@gmail.com**

The only official source is <https://cypherstore.vercel.app>. A copy from
anywhere else is not one Kencypher published.

Full terms: [LICENSE.txt](LICENSE.txt)
