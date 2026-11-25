# Cypher Trainer — store listing

Every sentence below comes from the Cypher Store website (site/projects.apps.js) or the GitHub release. Nothing is added.

| Field | Value |
|---|---|
| Name | Cypher Trainer |
| Short description | Runs your Windows game trainers with Steam and Proton games on Linux, and checks they connect. |
| Website | https://cypherstore.vercel.app/projects/cypher-trainer |
| Licence | Proprietary freeware, free of charge — https://github.com/kencypher56/cypher-releases/blob/master/LICENSE.txt |
| Developer | Muhammad Waleed Amjad (Kencypher), https://github.com/kencypher56 |
| Support | https://github.com/kencypher56/cypher-releases/issues |
| Privacy policy | **None published yet.** Huawei AppGallery and Samsung Galaxy Store require a privacy policy URL. |
| Suggested category | Games / Utilities |
| Requirements | Linux (x64) |
| Price | Free; no ads (as the website says) |

## Versions and files

| Platform | File | Version |
|---|---|---|
| Linux (appimage) | CypherTrainer-1.0.0-x86_64.AppImage | 1.0.0 |

## Long description

Cypher Trainer runs your Windows game trainers, FLiNG first, alongside games you play through Steam and Proton on Linux. It finds your Steam games by itself, notices when you start one, works out which process is really the game, and starts the trainer inside that game's own Proton session. Then it checks that the trainer can actually see and read the game, and tells you plainly whether it can.

What it does:

- Finds your Steam games: Native, Flatpak and Snap Steam and every library folder, with the Proton build each game uses, GE-Proton and custom tools included.
- Sees the game start: It tells the real game apart from Proton, Wine services, launchers and crash handlers, with a confidence score. Uncertain matches never get a trainer automatically.
- Imports trainers safely: .exe trainers or .zip, .rar and .7z archives, matched to your games by name and version. Archives are unpacked safely and nothing runs on import.
- The game's own Proton session: The trainer starts with the game's prefix, Proton build and sync mode, so it joins the same Wine session as the game.
- Checks the connection: A small probe confirms the trainer can see the game and read its memory. Connected shows only when every check passes.
- Stays out of the way: It never activates cheats for you, never needs root, changes no kernel settings, and is turned off for games that ship EasyAntiCheat or BattlEye.

## Icon

- Store icon source: `/mnt/kencypher/Desktop/cypher trainer/packaging/icons/icon.png (512 px)`
- Web copy: https://cypherstore.vercel.app/img/icons/cypher-trainer-256.png
- AppGallery wants 216 × 216 and Galaxy Store 512 × 512: scale the source down, never up.

## Screenshots

Desktop (portfolio/public/img/shots/, 2160 × 1350 PNG):

- `cypher-trainer-dashboard.png` — A game detected live, with its Proton build and process
- `cypher-trainer-games.png` — Every Steam game found, with its Proton build
- `cypher-trainer-trainers.png` — Imported trainers and the games they belong to

## Release notes — cypher-trainer-v1.0.0

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-trainer-v1.0.0

Runs your Windows game trainers (FLiNG first) with games you play through Steam and Proton on Linux.

## What's in 1.0.0

First release.

- **Finds your Steam games** (native, Flatpak and Snap Steam, every library) and the Proton build each one uses.
- **Notices when a game starts** and works out which process is really the game.
- **Starts the trainer inside the game's own Proton session**, then checks that it can actually see and read the game. "Connected" shows only when every check passes.
- **Imports trainers** from `.exe`, `.zip`, `.rar` or `.7z`, matched to your games automatically or by you. Imported files are never run on import.
- **Stops the trainer** when the game closes.

It never activates cheats by itself, never needs root, and is disabled for games that ship EasyAntiCheat or BattlEye.

## Run (Linux x64)

    chmod +x CypherTrainer-1.0.0-x86_64.AppImage
    ./CypherTrainer-1.0.0-x86_64.AppImage

It uses the static AppImage runtime, so it doesn't need libfuse2. Data stays in your home folder.

Each file has a matching `.sha256`.
