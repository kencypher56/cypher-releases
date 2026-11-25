# Cypher Visualizer — store listing

Every sentence below comes from the Cypher Store website (site/projects.apps.js) or the GitHub release. Nothing is added.

| Field | Value |
|---|---|
| Name | Cypher Visualizer |
| Short description | A real-time visualizer for whatever your computer is playing, drawn in a small desktop overlay. |
| Website | https://cypherstore.vercel.app/projects/cypher-visualizer |
| Licence | Proprietary freeware, free of charge — https://github.com/kencypher56/cypher-releases/blob/master/LICENSE.txt |
| Developer | Muhammad Waleed Amjad (Kencypher), https://github.com/kencypher56 |
| Support | https://github.com/kencypher56/cypher-releases/issues |
| Privacy policy | **None published yet.** Huawei AppGallery and Samsung Galaxy Store require a privacy policy URL. |
| Suggested category | Multimedia / Music |
| Requirements | Windows 10/11 (64-bit); Linux (x64) |
| Price | Free; no ads (as the website says) |

## Versions and files

| Platform | File | Version |
|---|---|---|
| Windows (exe) | CypherVisualizer-Setup-1.1.0.exe | 1.1.0 |
| Linux (appimage) | CypherVisualizer-1.1.0-x86_64.AppImage | 1.1.0 |

## Long description

Cypher Visualizer turns whatever your computer is already playing, from YouTube and Spotify to VLC and games, into a live visualization in a corner of your desktop. There is no window around it, no background and nothing to click: the mouse goes straight through to whatever sits underneath. Thirty visualizers, from GLava-style bars to 3D tunnels, follow the bass, mids and treble as they happen.

What it does:

- System audio, never a microphone: Windows captures what is playing with WASAPI loopback; Linux reads the PipeWire or PulseAudio monitor of your output. No drivers, no virtual cables, and nothing on your screen is ever captured.
- Clicks go straight through: The overlay has no frame, no background and no buttons, and never takes a mouse click, so the desktop and every window under it stay fully usable.
- Thirty visualizers: GLava-style bars, graphs and radials, spectrum and waveform views, particles, liquid, and 3D scenes from tunnels to terrain. Search them, or filter by 2D, 3D, particles and more.
- Make the look yours: Palettes, glow, bloom, motion trails, film grain and more, with sensitivity, smoothing and beat detection to tune the reaction. Save a look as a preset, or export it to a file.
- Write your own in Lua: The Lua Script visualizer runs your own script every frame against the live spectrum, waveform and beats, with example scripts to start from.
- Light by design: It stays on the power-saving graphics chip, lets you cap the frame rate, and fades out and stops drawing while nothing is playing, waking the moment audio returns.

## Icon

- Store icon source: `/mnt/kencypher/Desktop/Cypher Visualizer/build/icon.png (512 px)`
- Web copy: https://cypherstore.vercel.app/img/icons/cypher-visualizer-256.png
- AppGallery wants 216 × 216 and Galaxy Store 512 × 512: scale the source down, never up.

## Screenshots

Desktop (portfolio/public/img/shots/, 1440 × 900 PNG):

- `cypher-visualizer-gallery.png` — Pick from the visualizers, each with a live preview
- `cypher-visualizer-audio.png` — System audio source, live levels and sensitivity
- `cypher-visualizer-colors.png` — Palettes and colour modes

## Release notes — cypher-visualizer-v1.1.0

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-visualizer-v1.1.0

A visualizer for the audio already playing on your computer, drawn straight onto your desktop.

## What's new in 1.1.0

- **Clearer control panel.** New type (Albert Sans), nothing smaller than 12 px, and plain status lines such as "No sound playing".
- **A solid Start button** and a solid marker for the section you are in.
- **Full scrollbars** on a visible track.

## Install (Windows 10/11, 64-bit)

Run `CypherVisualizer-Setup-1.1.0.exe`. It installs to
`C:\Program Files\Cypher Visualizer`, adds Start menu and desktop shortcuts,
and can start the visualizer with Windows.

## Run (Linux x64, glibc 2.35+)

    chmod +x CypherVisualizer-1.1.0-x86_64.AppImage
    ./CypherVisualizer-1.1.0-x86_64.AppImage

System audio needs `pulseaudio-utils` (on PipeWire desktops also
`pipewire-pulse`), and AppImages need `libfuse2` (or run it with
`--appimage-extract-and-run`). Optional: `wmctrl`, to sit on the desktop
behind your windows under X11.

---

**Free to use. Not open source.** Made by Kencypher (Muhammad Waleed Amjad),
sole author and copyright holder. Run it, share an unmodified copy, keep it
forever. Do not sell it, rebrand it, re-upload it, or publish it as your own.

The official sources for this software are **[Cypher Store](https://cypherstore.vercel.app/projects/cypher-visualizer)** and the store listings it links to.
A copy from anywhere else is not one I published, and nothing about what is
inside it is guaranteed.

Every file here has a `.sha256` beside it. Windows may warn that the
publisher is unrecognised, because the installer is not code-signed — choose
**More info**, then **Run anyway**.
