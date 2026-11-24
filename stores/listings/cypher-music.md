# Cypher Music — store listing

Every sentence below comes from the Cypher Store website (site/projects.apps.js) or the GitHub release. Nothing is added.

| Field | Value |
|---|---|
| Name | Cypher Music |
| Short description | Offline music and video player with a link downloader and an on-device vocal and instrument separator. |
| Website | https://cypherstore.vercel.app/projects/cypher-music |
| Licence | Proprietary freeware, free of charge — https://github.com/kencypher56/cypher-releases/blob/master/LICENSE.txt |
| Developer | Muhammad Waleed Amjad (Kencypher), https://github.com/kencypher56 |
| Support | https://github.com/kencypher56/cypher-releases/issues |
| Privacy policy | **None published yet.** Huawei AppGallery and Samsung Galaxy Store require a privacy policy URL. |
| Suggested category | Music & Audio |
| Requirements | Windows 10/11; Linux (x64); Android 7.0+ |
| Price | Free; no ads (as the website says) |

## Versions and files

| Platform | File | Version |
|---|---|---|
| Windows (exe) | CypherMusic-Setup-2.141.exe | 2.141 |
| Linux (appimage) | CypherMusic-2.141-x86_64.AppImage | 2.141 |
| Android (apk) | CypherMusic-2.141.apk | 2.141 |

## Android package

- Package name: `com.cyphermusic.app`, versionCode 2141
- Minimum Android 7.0 (API 24), target API 33
- Native code: arm64-v8a, armeabi-v7a
- Signature schemes: v2; signing certificate SHA-256 `8b8254fbb26b6530c46d703d44572a434325d93cef13b66a66da04ccb12aef0f`
- Permissions the stores will ask about: READ_MEDIA_AUDIO, READ_MEDIA_VIDEO, READ/WRITE_EXTERNAL_STORAGE (old Android only), MANAGE_EXTERNAL_STORAGE, ACCESS_MEDIA_LOCATION, FOREGROUND_SERVICE (media playback, data sync), WAKE_LOCK, REQUEST_IGNORE_BATTERY_OPTIMIZATIONS, POST_NOTIFICATIONS, RECEIVE_BOOT_COMPLETED, MODIFY_AUDIO_SETTINGS, INTERNET, ACCESS_NETWORK_STATE

## Long description

Cypher Music is a full offline media library — songs, albums, artists, playlists and videos, all scanned from the machine it runs on. On top of the player it carries two things most players do not: a downloader that pulls audio or video from hundreds of sites, and a vocal and instrument separator that pulls a finished track apart into its vocal and instrumental stems. Both of them run on your own computer or phone, with nothing uploaded anywhere.

What it does:

- Vocal and instrument separator: Split any track in your library into a clean vocal stem and an instrumental one. Take both, take the vocals alone, or take the instrumental alone and use it as karaoke.
- Separation runs on your own machine: The same Spleeter 2-stem U-Net on all three platforms — through TensorFlow Lite on the phone and ONNX Runtime on Windows and Linux. Nothing is uploaded, nothing is queued on a server, and it works with the network off.
- Phase-preserving output: The model produces soft masks that scale the original spectrum instead of rebuilding it from scratch, so the stems keep their original phase and avoid the metallic ring cheaper splitters leave behind.
- Full local library: Songs, albums, artists and playlists scanned straight off the device. No account, no sync, nothing needed to play.
- Built-in downloader: Paste a link from YouTube, TikTok, Instagram and hundreds more. Pick audio, video, both, or a whole playlist, at up to 320 kbps in M4A, MP3, AAC, WAV or FLAC.
- Video library too: Local video playback with the same treatment: sort by newest, oldest, A-Z, duration or size, and mix videos into playlists alongside music.

## Icon

- Store icon source: `/mnt/kencypher/Desktop/cypher-releases/desktop/icons/CypherMusic.png (512 px)`
- Web copy: https://cypherstore.vercel.app/img/icons/cypher-music-256.png
- AppGallery wants 216 × 216 and Galaxy Store 512 × 512: scale the source down, never up.

## Screenshots

Desktop (portfolio/public/img/shots/, 2160 × 1350 PNG):

- `cypher-music-home.png` — Listen: recently added, albums and artists
- `cypher-music-library.png` — The song library, with sorting and shuffle
- `cypher-music-player.png` — Now playing beside the library
- `cypher-music-playlists.png` — Playlists
- `cypher-music-downloads.png` — The downloader: paste a link, pick the format and quality

Phone (portfolio/public/img/shots/phone/, 1170 × 2532 PNG):

- `cypher-music-home.png` — Listen: recently added, albums and artists
- `cypher-music-library.png` — The song library
- `cypher-music-player.png` — Now playing
- `cypher-music-playlists.png` — Playlists

## Release notes — cypher-music-v2.141

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-music-v2.141

Offline music and video library, a downloader for hundreds of sites, and a
vocal/instrumental splitter — all of it on your own machine.

## What's new in 2.141

Android, Windows and Linux, all on the same version.

- **A new Listen home.** Opens on what you were playing, with a resume card, then shelves of recently added music, albums and artists.
- **The room takes the colour of the cover** that is playing.
- **Calmer, smaller type.** One typeface (Manrope) at a compact, even scale.
- **Better player controls.** The seek bar shows the time as you drag, the track length sits on the right, and volume shows its percentage.
- **Much smoother on phones.** Scrolling no longer drops frames, and switching tabs is several times faster, even with thousands of songs and videos.
- **Linux is an AppImage now.** One file: make it executable and run it.

## The files

| File | For |
|---|---|
| `CypherMusic-Setup-2.141.exe` | Windows 10/11 — installs to Program Files, desktop shortcut |
| `CypherMusic-2.141-x86_64.AppImage` | Linux x64 — `chmod +x`, then run it. No install, no root |
| `CypherMusic-2.141.apk` | Android 7.0+ |

Updates install over the top and keep your library, playlists and custom
albums intact.

---

**Free to use. Not open source.** Made by Kencypher (Muhammad Waleed Amjad),
sole author and copyright holder. Run it, share an unmodified copy, keep it
forever. Do not sell it, rebrand it, re-upload it, or publish it as your own.

The only true source for this software is **[Cypher Store](https://cypherstore.vercel.app/projects/cypher-music)**.
A copy from anywhere else is not one I published, and nothing about what is
inside it is guaranteed.

Every file here has a `.sha256` beside it. Windows may warn that the
publisher is unrecognised, because the installer is not code-signed — choose
**More info**, then **Run anyway**.
