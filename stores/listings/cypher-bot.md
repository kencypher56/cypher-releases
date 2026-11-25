# Cypher BOT — store listing

Every sentence below comes from the Cypher Store website (site/projects.apps.js) or the GitHub release. Nothing is added.

| Field | Value |
|---|---|
| Name | Cypher BOT |
| Short description | Turns a Reddit thread into a narrated video, read in the character voices you pick. |
| Website | https://cypherstore.vercel.app/projects/cypher-bot |
| Licence | Proprietary freeware, free of charge — https://github.com/kencypher56/cypher-releases/blob/master/LICENSE.txt |
| Developer | Muhammad Waleed Amjad (Kencypher), https://github.com/kencypher56 |
| Support | https://github.com/kencypher56/cypher-releases/issues |
| Privacy policy | **None published yet.** Huawei AppGallery and Samsung Galaxy Store require a privacy policy URL. |
| Suggested category | Video / Multimedia |
| Requirements | Windows 10/11; Linux (x64); Android 5.1+ |
| Price | Free; no ads (as the website says) |
| Voice rights | The voice pack (cypher-bot-voices-v1) names real people and characters. You hold the rights to these voices (confirmed 2026-11-25); keep the proof ready, because a reviewer may ask for it. |

## Versions and files

| Platform | File | Version |
|---|---|---|
| Windows (exe) | CypherBot-Setup-1.123.exe | 1.123 |
| Linux (appimage) | CypherBot-1.131-x86_64.AppImage | 1.131 |
| Android (apk) | CypherBot-1.126.apk | 1.126 |

## Android package

- Package name: `com.cypherbot.app`, versionCode 1126
- Minimum Android 5.1 (API 22), target API 33
- Native code: arm64-v8a, armeabi-v7a, x86, x86_64
- Signature schemes: v1 + v2; signing certificate SHA-256 `3ceefccad1e815685a3fb5af6817b6d3223e1ea3f28c4db1bacc1558482aeb9e`
- Permissions the stores will ask about: READ_MEDIA_AUDIO, READ_MEDIA_VIDEO, READ/WRITE_EXTERNAL_STORAGE (old Android only), MANAGE_EXTERNAL_STORAGE, POST_NOTIFICATIONS, RECEIVE_BOOT_COMPLETED, FOREGROUND_SERVICE (media playback, data sync), WAKE_LOCK, REQUEST_IGNORE_BATTERY_OPTIMIZATIONS, ACCESS_NETWORK_STATE, MODIFY_AUDIO_SETTINGS, INTERNET

## Long description

Paste a Reddit thread, pick a voice, and Cypher BOT reads the post and its comments aloud over a background and renders the whole thing as a finished video file. The speech engine and every character voice run on the device — no server, no API key, and the thread you are reading is not uploaded anywhere.

What it does:

- Thread to script: Paste a thread link and it pulls the post and its comments, telling you how many it found before you commit to a render.
- Character voices: A library of built-in characters, each one auditionable with a play button before you use it.
- One voice or a whole cast: One Voice narrates everything in the same voice. Mix All gives every comment a different character.
- Backgrounds: Render over your own video clip. One is included so the first video needs nothing added, and on the desktop you can add more from the menu.
- Real encoding controls: MP4 or MKV, H.264 or H.265, 24/30/60 fps and an adjustable bitrate — not a fixed preset.
- On-device library: Every render is kept in the app with its file size, ready to play or share. On Windows and Linux the folder itself opens from the menu.

## Icon

- Store icon source: `/mnt/kencypher/Desktop/cypher-releases/desktop/bot/app/web_ui/public/icon.png (1024 px)`
- Web copy: https://cypherstore.vercel.app/img/icons/cypher-bot-256.png
- AppGallery wants 216 × 216 and Galaxy Store 512 × 512: scale the source down, never up.

## Screenshots

Desktop (portfolio/public/img/shots/, 2160 × 1350 PNG):

- `cypher-bot-script.png` — Paste a Reddit thread and the script appears, voiced line by line
- `cypher-bot-voices.png` — Character voices, each with a preview
- `cypher-bot-settings.png` — Video settings: container, codec, frame rate and bitrate

Phone (portfolio/public/img/shots/phone/, 1170 × 2532 PNG):

- `cypher-bot-script.png` — Paste a Reddit thread and the script appears, voiced line by line
- `cypher-bot-voices.png` — Character voices, each with a preview
- `cypher-bot-settings.png` — Video settings: container, codec, frame rate and bitrate

## Release notes — cypher-bot-v1.123

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-bot-v1.123

Paste a Reddit thread, pick a voice, and it reads the post and its comments
aloud over a background and renders a finished video.

## What's new in 1.123

Windows and Linux. Android stays on 1.126.

- **Check for updates, where you can see it.** Settings has a **Check for updates** button on Windows and Linux. The check was only in the menu bar, which hides itself, so most people never found it. It shows what changed before anything installs.

## The files

| File | For |
|---|---|
| `CypherBot-Setup-1.123.exe` | Windows 10/11 — everything inside, nothing to install first |
| `CypherBot-1.123.tar.gz` | Linux x64 — extract, run `./install.sh` once, then `./cypherbot` |
| `CypherBot-1.126.apk` | Android 5.1+ |

Finished videos and downloaded voices are kept in your own profile, not in
the installation folder, so an update never touches them.

---

**Free to use. Not open source.** Made by Kencypher (Muhammad Waleed Amjad),
sole author and copyright holder. Run it, share an unmodified copy, keep it
forever. Do not sell it, rebrand it, re-upload it, or publish it as your own.

The official sources for this software are **[Cypher Store](https://cypherstore.vercel.app/projects/cypher-bot)** and the store listings it links to.
A copy from anywhere else is not one I published, and nothing about what is
inside it is guaranteed.

Every file here has a `.sha256` beside it. Windows may warn that the
publisher is unrecognised, because the installer is not code-signed — choose
**More info**, then **Run anyway**.

## Release notes — cypher-bot-v1.131

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-bot-v1.131

Paste a Reddit thread, pick a voice, and it reads the post and its comments
aloud over a background and renders a finished video.

## What's new in 1.131

- **Linux is an AppImage, with Python inside.** No `install.sh`, no `python3-venv`, nothing to build first. Make it executable and run it.

## The file

| File | For |
|---|---|
| `CypherBot-1.131-x86_64.AppImage` | Linux x64. `chmod +x`, then run it. Python is inside |

```bash
chmod +x CypherBot-1.131-x86_64.AppImage
./CypherBot-1.131-x86_64.AppImage
```

Finished videos and downloaded voices are kept in your own profile, not in
the AppImage, so an update never touches them.

---

**Free to use. Not open source.** Made by Kencypher (Muhammad Waleed Amjad),
sole author and copyright holder. Run it, share an unmodified copy, keep it
forever. Do not sell it, rebrand it, re-upload it, or publish it as your own.

The official sources for this software are **[Cypher Store](https://cypherstore.vercel.app/projects/cypher-bot)** and the store listings it links to.
A copy from anywhere else is not one I published, and nothing about what is
inside it is guaranteed.

The file has a `.sha256` beside it.
