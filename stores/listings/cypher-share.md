# Cypher Share — store listing

Every sentence below comes from the Cypher Store website (site/projects.apps.js) or the GitHub release. Nothing is added.

| Field | Value |
|---|---|
| Name | Cypher Share |
| Short description | Sends files and whole folders between your computers and your phone, at the full speed of your own network. |
| Website | https://cypherstore.vercel.app/projects/cypher-share |
| Licence | Proprietary freeware, free of charge — https://github.com/kencypher56/cypher-releases/blob/master/LICENSE.txt |
| Developer | Muhammad Waleed Amjad (Kencypher), https://github.com/kencypher56 |
| Support | https://github.com/kencypher56/cypher-releases/issues |
| Privacy policy | **None published yet.** Huawei AppGallery and Samsung Galaxy Store require a privacy policy URL. |
| Suggested category | Tools / File transfer |
| Requirements | Windows 10/11 (64-bit); Linux (x64); Android 7.0+ |
| Price | Free; no ads (as the website says) |

## Versions and files

| Platform | File | Version |
|---|---|---|
| Windows (exe) | CypherShare-Setup-3.1.0.exe | 3.1.0 |
| Linux (appimage) | CypherShare-3.1.1-x86_64.AppImage | 3.1.1 |
| Android (apk) | CypherShare-3.1.0.apk | 3.1.0 |

## Android package

- Package name: `com.cypher.share`, versionCode 218
- Minimum Android 7.0 (API 24), target API 34
- Native code: arm64-v8a, armeabi-v7a, x86_64
- Signature schemes: v2; signing certificate SHA-256 `b97f9e82cb79e7c839837428e3f9e21c955811ecc8e4f4b9251b61a53fb30723`
- Permissions the stores will ask about: INTERNET, ACCESS_NETWORK_STATE, ACCESS_WIFI_STATE, CHANGE_WIFI_MULTICAST_STATE, WAKE_LOCK, READ_MEDIA_IMAGES, READ_MEDIA_VIDEO, READ_MEDIA_AUDIO, READ/WRITE_EXTERNAL_STORAGE (old Android only), MANAGE_EXTERNAL_STORAGE, POST_NOTIFICATIONS, RECEIVE_BOOT_COMPLETED

## Long description

Cypher Share moves files and entire folder trees between Windows and Linux computers and Android phones on the same local network. Start it on two devices and they find each other by themselves: there is no account, no pairing code and no server in the middle. Pick what to send, tap the device, and the receiver decides what comes in. The data travels device to device over parallel connections and never leaves your network.

What it does:

- Built to fill the wire: Eight parallel streams by default, small files batched into single requests, and big files first so every stream is busy from the start. The target is a gigabit network filled by one transfer.
- The receiver decides: An offer opens an approval sheet listing every file and folder with its size. Tick only what you want: anything left unticked is never sent, and the sender’s totals shrink to match.
- Resume, not restart: A record of every finished chunk means a cancelled transfer carries on from where it stopped when you send the same selection again, even hundreds of gigabytes in.
- Hard disks handled: A spinning disk loses nearly half its speed to scattered reads. When the files or the receive folder are on one, it switches to fewer streams and long sequential reads by itself.
- Stays on your network: Discovery beacons cannot cross a router, peer traffic never goes through a proxy, and every path arriving from another machine is checked before anything is written.
- Optional verification: Switch it on and both machines read every file again once it lands and compare SHA-256 digests, naming any file that differs.

## Icon

- Store icon source: `/mnt/kencypher/Desktop/cypher-share/assets/icon-1024.png (1024 px)`
- Web copy: https://cypherstore.vercel.app/img/icons/cypher-share-256.png
- AppGallery wants 216 × 216 and Galaxy Store 512 × 512: scale the source down, never up.

## Screenshots

Desktop (portfolio/public/img/shots/, 2160 × 1350 PNG):

- `cypher-share-send.png` — Pick what to send and a nearby device
- `cypher-share-receive.png` — How other devices see you, where files are saved and what came in
- `cypher-share-settings.png` — Receiving rules, devices and transfer speed

Phone (portfolio/public/img/shots/phone/, 1170 × 2532 PNG):

- `cypher-share-send.png` — Pick what to send and a nearby device
- `cypher-share-receive.png` — How other devices see you, where files are saved and what came in
- `cypher-share-settings.png` — Receiving rules, devices and transfer speed

## Release notes — cypher-share-v3.1.0

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-share-v3.1.0

Files and folders, device to device, over your own network.

## What's new in 3.1.0

Android, Windows and Linux, all on the same version.

- **Send reads as a route.** Pick what to send, pick the device, and the Send bar above the tabs shows both. Send is never greyed out: if a step is missing, it takes you there.
- **Receive starts with the name** other devices see you as.
- **A new look in light and dark**, in night blues, with one typeface (Red Hat Text) at an even size scale.
- **Scrollbars on Windows and Linux** in both directions.
- Updating keeps your transfer history.

## The files

| File | For |
|---|---|
| `CypherShare-Setup-3.1.0.exe` | Windows 10/11 |
| `CypherShare-3.1.0-x86_64.AppImage` | Linux x64 — `chmod +x`, then run it |
| `CypherShare-3.1.0.apk` | Android 7.0+ |

---

**Free to use. Not open source.** Made by Kencypher (Muhammad Waleed Amjad),
sole author and copyright holder. Run it, share an unmodified copy, keep it
forever. Do not sell it, rebrand it, re-upload it, or publish it as your own.

The only true source for this software is **[Cypher Store](https://cypherstore.vercel.app/projects/cypher-share)**.
A copy from anywhere else is not one I published, and nothing about what is
inside it is guaranteed.

Every file here has a `.sha256` beside it. Windows may warn that the
publisher is unrecognised, because the installer is not code-signed — choose
**More info**, then **Run anyway**.

## Release notes — cypher-share-v3.1.1

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-share-v3.1.1

Files and folders, device to device, over your own network.

## What's new in 3.1.1

Linux only. Windows and Android stay on 3.1.0, which did not have this problem.

- **The file browser fits the window again.** On Linux it could grow taller than the window, which hid its title, its search, the drive shortcuts and the Add button, and left nothing to scroll. It now stays inside the window, the list scrolls with a visible scrollbar, and the drive shortcuts scroll sideways.

## The file

| File | For |
|---|---|
| `CypherShare-3.1.1-x86_64.AppImage` | Linux x64 — `chmod +x`, then run it |

Your transfer history and settings are kept.

---

**Free to use. Not open source.** Made by Kencypher (Muhammad Waleed Amjad),
sole author and copyright holder. Run it, share an unmodified copy, keep it
forever. Do not sell it, rebrand it, re-upload it, or publish it as your own.

The only true source for this software is **[Cypher Store](https://cypherstore.vercel.app/projects/cypher-share)**.
A copy from anywhere else is not one I published, and nothing about what is
inside it is guaranteed.

The file has a `.sha256` beside it.
