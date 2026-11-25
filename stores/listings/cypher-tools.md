# Cypher Tools — store listing

Every sentence below comes from the Cypher Store website (site/projects.apps.js) or the GitHub release. Nothing is added.

| Field | Value |
|---|---|
| Name | Cypher Tools |
| Short description | Sixty-eight offline tools for PDFs, Office files, images, audio, video and archives. Drop a file, pick a tool, done. |
| Website | https://cypherstore.vercel.app/projects/cypher-tools |
| Licence | Proprietary freeware, free of charge — https://github.com/kencypher56/cypher-releases/blob/master/LICENSE.txt |
| Developer | Muhammad Waleed Amjad (Kencypher), https://github.com/kencypher56 |
| Support | https://github.com/kencypher56/cypher-releases/issues |
| Privacy policy | **None published yet.** Huawei AppGallery and Samsung Galaxy Store require a privacy policy URL. |
| Suggested category | Tools / Productivity |
| Requirements | Windows 10/11 (64-bit); Linux (x64); Android 10+ |
| Price | Free; no ads (as the website says) |

## Versions and files

| Platform | File | Version |
|---|---|---|
| Windows (exe) | CypherTools-Setup-1.1.0.exe | 1.1.0 |
| Linux (appimage) | CypherTools-1.1.0-x86_64.AppImage | 1.1.0 |
| Android (apk) | CypherTools-1.1.0.apk | 1.1.0 |

## Android package

- Package name: `com.cypher.tools`, versionCode 8
- Minimum Android 10 (API 29), target API 34
- Native code: none (no native code)
- Signature schemes: v2; signing certificate SHA-256 `0a574e73dca52d25aeb18ad6cda669007dae8eddd38aa17ddeffad1d3e1beeee`
- Permissions the stores will ask about: INTERNET, READ_MEDIA_IMAGES, READ_MEDIA_VIDEO, READ_MEDIA_AUDIO, READ/WRITE_EXTERNAL_STORAGE (old Android only)

## Long description

Cypher Tools is one toolbox for the file jobs that usually send you to a website: MP4 to MP3, Word to PDF, PDF to Excel, signing a PDF, shrinking photos, ZIP to RAR. Drop a file and it shows the tools that fit. All 68 tools run on your own device, with no account and no upload, and the result lands next to the original without touching it. On a PC it drives real engines: a bundled ffmpeg, Microsoft Office or LibreOffice, and WinRAR.

What it does:

- 42 PDF tools: Edit existing text, fill and sign forms, make any PDF fillable, merge, split by pages, bookmarks, size or text, reorder and crop pages, OCR scans, compress, protect with AES-256, unlock and repair.
- Office the real way: Word, Excel and PowerPoint to PDF through Microsoft Office itself, or LibreOffice when Office is not there, so the PDF looks the way the document does. PDFs go back to Word, Excel and PowerPoint too.
- Audio and video: MP4 to MP3, any video to MP4, MKV, MOV, WEBM or AVI, audio to MP3, M4A, FLAC, WAV or OGG, plus compress, trim, mute, video to GIF and SRT, VTT and ASS subtitles.
- Images, any format: Convert between JPG, PNG, WebP, AVIF, GIF and iPhone HEIC photos, compress, resize, rotate, make animated GIFs, and strip GPS and camera details before you share a photo.
- Archives both ways: Unpack ZIP, RAR, 7Z, TAR and ISO, and create ZIP, 7Z, RAR or TAR. ZIP to RAR and RAR to ZIP in one step, with real RAR compression when WinRAR is installed.
- Your originals stay put: Nothing is uploaded and nothing is overwritten: road-trip.mp4 becomes road-trip.mp3 beside it, and a name that is taken becomes name (1). Damaged or mislabelled files are caught before a tool runs.

## Icon

- Store icon source: `/mnt/kencypher/Desktop/cypher tools/assets/icon-source.png (2048 px)`
- Web copy: https://cypherstore.vercel.app/img/icons/cypher-tools-256.png
- AppGallery wants 216 × 216 and Galaxy Store 512 × 512: scale the source down, never up.

## Screenshots

Desktop (portfolio/public/img/shots/, 2160 × 1350 PNG):

- `cypher-tools-home.png` — Drop files, or browse all 68 tools
- `cypher-tools-pdf.png` — PDF tools: edit, sign, merge and split
- `cypher-tools-convert.png` — An image converted, with the result saved next to it
- `cypher-tools-settings.png` — Light and dark mode, and seven accent colours

Phone (portfolio/public/img/shots/phone/, 1170 × 2532 PNG):

- `cypher-tools-home.png` — Drop files, or browse all 68 tools
- `cypher-tools-pdf.png` — PDF tools: edit, sign, merge and split
- `cypher-tools-convert.png` — An image converted, with the result saved next to it
- `cypher-tools-settings.png` — Light and dark mode, and seven accent colours

## Release notes — cypher-tools-v1.1.0

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-tools-v1.1.0

One offline toolbox for your files: 68 tools for PDFs, Office documents, images, audio, video and archives, on Windows, Linux and Android.

## What's new in 1.1.0

- **One workbench look**, in light and dark, with seven accent colours. The Ghibli and Cyberpunk themes are retired; your saved accent carries over.
- **Plain type** (IBM Plex Sans) at an even size scale.
- **The main button always works.** Before you add files it opens the file picker instead of sitting greyed out.
- **Scrollbars on Windows and Linux** in both directions.
- Updating keeps your accent and your recent tools.

## Install (Windows 10/11, 64-bit)

Run `CypherTools-Setup-1.1.0.exe`. It installs to
`C:\Program Files\Cypher Tools`, adds Start menu and desktop shortcuts, and
can add **Open with Cypher Tools** to the right-click menu of every file.

## Run (Linux x64)

    chmod +x CypherTools-1.1.0-x86_64.AppImage
    ./CypherTools-1.1.0-x86_64.AppImage

ffmpeg is inside the AppImage, so nothing needs installing. AppImages need
`libfuse2`; without it, run it with `--appimage-extract-and-run`. For Office
files install LibreOffice, and for compressed RAR output install `rar`.

## Install (Android 10+)

Open `CypherTools-1.1.0.apk` and allow installs from your browser or file
manager when asked. Results are saved to `Documents/Cypher Tools`.

---

**Free to use. Not open source.** Made by Kencypher (Muhammad Waleed Amjad),
sole author and copyright holder. Run it, share an unmodified copy, keep it
forever. Do not sell it, rebrand it, re-upload it, or publish it as your own.

The official sources for this software are **[Cypher Store](https://cypherstore.vercel.app/projects/cypher-tools)** and the store listings it links to.
A copy from anywhere else is not one I published, and nothing about what is
inside it is guaranteed.

Every file here has a `.sha256` beside it. Windows may warn that the
publisher is unrecognised, because the installer is not code-signed — choose
**More info**, then **Run anyway**.
