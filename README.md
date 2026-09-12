# Cypher — Releases

Downloads for the Cypher applications, by [Kencypher](https://github.com/kencypher56).

**This repository holds releases only.** There is no application source here —
the builds are produced elsewhere and published to the Releases page.

> Full feature lists, screenshots and setup guides for every app live on the
> site: **https://cypherstore.netlify.app**

---

## The apps

| App | Android | Windows | Linux | What it is |
|---|:--:|:--:|:--:|---|
| **Cypher Music** | ✅ | ✅ | ✅ | Offline music and video library, a downloader for hundreds of sites, and a vocal/instrumental splitter |
| **Cypher BOT** | ✅ | ✅ | ✅ | Turns a Reddit thread into a narrated short video with character voices |
| **Cypher Contacts** | ✅ | ✅ | ✅ | Contacts manager that exports and imports in eleven formats |
| **Cypher Expenses** | ✅ | ✅ | ✅ | Expense and income tracker that produces a real PDF statement |
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

The applications are free to download and use. The source is not published.
