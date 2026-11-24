# Cypher Expenses — store listing

Every sentence below comes from the Cypher Store website (site/projects.apps.js) or the GitHub release. Nothing is added.

| Field | Value |
|---|---|
| Name | Cypher Expenses |
| Short description | Records expenses and money in, and turns them into statements and PDF reports. |
| Website | https://cypherstore.vercel.app/projects/cypher-expenses |
| Licence | Proprietary freeware, free of charge — https://github.com/kencypher56/cypher-releases/blob/master/LICENSE.txt |
| Developer | Kencypher (https://github.com/kencypher56) |
| Support | https://github.com/kencypher56/cypher-releases/issues |
| Privacy policy | **None published yet.** Huawei AppGallery and Samsung Galaxy Store require a privacy policy URL. |
| Suggested category | Finance |
| Requirements | Windows 10/11; Linux (x64); Android 6.0+ |
| Price | Free; no ads (as the website says) |

## Versions and files

| Platform | File | Version |
|---|---|---|
| Windows (exe) | CypherExpenses-Setup-3.11.exe | 3.11 |
| Linux (appimage) | CypherExpenses-3.11-x86_64.AppImage | 3.11 |
| Android (apk) | CypherExpenses-3.11.apk | 3.11 |

## Android package

- Package name: `com.kecypher.cypherexpenses`, versionCode 15
- Minimum Android 6.0 (API 23), target API 34
- Native code: none (no native code)
- Signature schemes: v1 + v2; signing certificate SHA-256 `210902612132a4ac71eb4d22ef82d36915c4ae2f105099d9e2026795ef9d2a51`
- Permissions the stores will ask about: POST_NOTIFICATIONS, RECEIVE_BOOT_COMPLETED

## Long description

Money in, money out, and an honest answer to where it went. Cypher Expenses keeps a running balance, breaks spending down by category, and exports a detailed or summary statement as a PDF for any date range. Everything is stored on the device and it never asks you to make an account.

What it does:

- Dashboard at a glance: Current balance, total added, total spent and this month’s spend, all on the first screen.
- Log an expense: Category, amount and an optional remark. Three fields and it is recorded.
- Log income: Record where money came from, so the running balance actually means something.
- Spending by category: A breakdown that shows which categories are quietly consuming the month.
- PDF statements: Pick a date range, choose expenses, income or both, and detailed or summary, then export a real PDF.
- Local and private: No account, no sync, no network. The data lives in the app and nowhere else.

## Icon

- Store icon source: `/mnt/kencypher/Desktop/cypher-releases/desktop/icons/CypherExpenses.png (512 px)`
- Web copy: https://cypherstore.vercel.app/img/icons/cypher-expenses-256.png
- AppGallery wants 216 × 216 and Galaxy Store 512 × 512: scale the source down, never up.

## Screenshots

Desktop (portfolio/public/img/shots/, 2160 × 1350 PNG):

- `cypher-expenses-ledger.png` — The ledger: balance, where the money went and entries by day
- `cypher-expenses-add.png` — Adding an expense
- `cypher-expenses-reports.png` — Reports: a statement of account with PDF export
- `cypher-expenses-settings.png` — Settings: profile and appearance

Phone (portfolio/public/img/shots/phone/, 1170 × 2532 PNG):

- `cypher-expenses-ledger.png` — The ledger: balance, where the money went and entries by day
- `cypher-expenses-add.png` — Adding an expense
- `cypher-expenses-reports.png` — Reports: a statement of account with PDF export
- `cypher-expenses-settings.png` — Settings: profile and appearance

## Release notes — cypher-expenses-v3.11

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-expenses-v3.11

An expense and income tracker that produces a real statement of account as a
PDF, not a screenshot of a list.

## What's new in 3.11

Android, Windows and Linux, all on the same version.

- **A new Ledger home.** Your balance first, then where the money went by category, then entries by day.
- **One Add sheet** for expenses and money in. The keyboard waits until you tap Amount, the field stays above it, and a mistake is pointed out when you leave the field, then clears as you fix it.
- **Reports with ready periods** (this month, last month and so on) and a live statement before you export the PDF.
- **Icons instead of emoji**, and theme swatches in Settings.
- **Linux is an AppImage now.** Make it executable and run it.

Your records stay where they are: updating keeps every entry.

## The files

| File | For |
|---|---|
| `CypherExpenses-Setup-3.11.exe` | Windows 10/11 |
| `CypherExpenses-3.11-x86_64.AppImage` | Linux x64 — `chmod +x`, then run it |
| `CypherExpenses-3.11.apk` | Android 6.0+ |

---

**Free to use. Not open source.** Made by Kencypher (Muhammad Waleed Amjad),
sole author and copyright holder. Run it, share an unmodified copy, keep it
forever. Do not sell it, rebrand it, re-upload it, or publish it as your own.

The only true source for this software is **[Cypher Store](https://cypherstore.vercel.app/projects/cypher-expenses)**.
A copy from anywhere else is not one I published, and nothing about what is
inside it is guaranteed.

Every file here has a `.sha256` beside it. Windows may warn that the
publisher is unrecognised, because the installer is not code-signed — choose
**More info**, then **Run anyway**.
