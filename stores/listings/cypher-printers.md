# Cypher Printers — store listing

Every sentence below comes from the Cypher Store website (site/projects.apps.js) or the GitHub release. Nothing is added.

| Field | Value |
|---|---|
| Name | Cypher Printers |
| Short description | Finds your printers, checks each driver is right for the exact model, and installs a verified one. |
| Website | https://cypherstore.vercel.app/projects/cypher-printers |
| Licence | Proprietary freeware, free of charge — https://github.com/kencypher56/cypher-releases/blob/master/LICENSE.txt |
| Developer | Muhammad Waleed Amjad (Kencypher), https://github.com/kencypher56 |
| Support | https://github.com/kencypher56/cypher-releases/issues |
| Privacy policy | **None published yet.** Huawei AppGallery and Samsung Galaxy Store require a privacy policy URL. |
| Suggested category | Utilities / System |
| Requirements | Windows 10/11 (64-bit); Linux (x64) |
| Windows testing | Its README says the Windows driver steps were only simulated or run under Wine and must be tested on Windows 10 and 11 before release. |
| Price | Free; no ads (as the website says) |

## Versions and files

| Platform | File | Version |
|---|---|---|
| Windows (portable) | CypherPrinters-1.0.0.exe | 1.0.0 |
| Linux (appimage) | CypherPrinters-1.0.0-x86_64.AppImage | 1.0.0 |

## Long description

Cypher Printers finds the printers connected over USB, Ethernet and Wi-Fi, works out the exact model, checks whether the installed driver is right for that model and your system, and installs a verified driver when one is missing. It never installs a driver just because the brand matches, and it goes online only to fetch a driver: through your package manager on Linux, or from Windows Update, the Microsoft Update Catalog and the manufacturer's own site on Windows.

What it does:

- Finds every printer: USB plus network discovery over mDNS/DNS-SD, WS-Discovery and SNMP, with an optional subnet scan. Add a printer by IP address when it does not announce itself.
- Checks the driver is right: Each printer gets a plain status: compatible, update available, incompatible, not verified, or no verified driver found.
- Verified drivers only: A driver is installed only when it names this exact model by hardware ID, model name or the manufacturer's own model range. On Windows its signature must be valid.
- Manage every printer: Print queue, default options, test page, pause and resume, reconnect, set as default, or remove.
- Installation history: Every install, removal and change with its real result, failures included, and a diagnostics zip to export.
- Troubleshooting: Live checks for eight common printing problems, each with the next step to take.

## Icon

- Store icon source: `/mnt/kencypher/Desktop/cypher printers/build/icon.png (512 px)`
- Web copy: https://cypherstore.vercel.app/img/icons/cypher-printers-256.png
- AppGallery wants 216 × 216 and Galaxy Store 512 × 512: scale the source down, never up.

## Screenshots

Desktop (portfolio/public/img/shots/, 2160 × 1350 PNG):

- `cypher-printers-discover.png` — Discover printers on USB and your network
- `cypher-printers-setup.png` — Set up a printer with a verified driver for its exact model
- `cypher-printers-drivers.png` — Which driver each printer uses, and whether it is right

## Release notes — cypher-printers-v1.0.0

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-printers-v1.0.0

Finds the printers connected over USB, Ethernet and Wi-Fi, identifies the exact model, checks that the installed driver is right for it, and installs a verified driver when one is missing.

## What's in 1.0.0

First release.

- **Discover** printers on USB, Ethernet and Wi-Fi, and see which need a driver.
- **Driver check** for the exact model and your operating system.
- **Install** a verified driver: on Linux through your package manager, on Windows from Windows Update, the Microsoft Update Catalog or the manufacturer's official support site.
- **History** of installs and changes.

It runs on your computer, with no account and no cloud service. It goes online only when you set up a printer.

## Run (Windows 10/11, 64-bit)

`CypherPrinters-1.0.0.exe` is one standalone file: download it and double-click it. There is no installer. Installing or removing a driver shows the Windows UAC prompt; the app itself never runs as administrator.

## Run (Linux x64)

    chmod +x CypherPrinters-1.0.0-x86_64.AppImage
    ./CypherPrinters-1.0.0-x86_64.AppImage

Printing goes through CUPS. Installing a driver asks for your password in your desktop's own PolicyKit window. AppImages need FUSE 2; without it, run with `--appimage-extract-and-run`.

Each file has a matching `.sha256`.
