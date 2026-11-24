# Cypher Contacts — store listing

Every sentence below comes from the Cypher Store website (site/projects.apps.js) or the GitHub release. Nothing is added.

| Field | Value |
|---|---|
| Name | Cypher Contacts |
| Short description | Exports your address book eleven ways and imports it back, on your own device. |
| Website | https://cypherstore.vercel.app/projects/cypher-contacts |
| Licence | Proprietary freeware, free of charge — https://github.com/kencypher56/cypher-releases/blob/master/LICENSE.txt |
| Developer | Muhammad Waleed Amjad (Kencypher), https://github.com/kencypher56 |
| Support | https://github.com/kencypher56/cypher-releases/issues |
| Privacy policy | **None published yet.** Huawei AppGallery and Samsung Galaxy Store require a privacy policy URL. |
| Suggested category | Productivity / Tools |
| Requirements | Windows 10/11; Linux (x64); Android 10+ |
| Price | Free; no ads (as the website says) |

## Versions and files

| Platform | File | Version |
|---|---|---|
| Windows (exe) | CypherContacts-Setup-1.18.exe | 1.18 |
| Linux (appimage) | CypherContacts-1.18-x86_64.AppImage | 1.18 |
| Android (apk) | CypherContacts-1.18.apk | 1.18 |

## Android package

- Package name: `com.cypher.contact`, versionCode 18
- Minimum Android 10 (API 29), target API 34
- Native code: none (no native code)
- Signature schemes: v2; signing certificate SHA-256 `bb5634c8b555a90286554a2cf2fbc209cd85af8db5359266bf941380a513da2b`
- Permissions the stores will ask about: READ_CONTACTS, WRITE_CONTACTS, GET_ACCOUNTS, READ_PHONE_STATE, POST_NOTIFICATIONS, RECEIVE_BOOT_COMPLETED, REQUEST_DELETE_PACKAGES

## Long description

Most phones will happily show you your contacts and then fight you when you try to take them somewhere else. Cypher Contacts is built around the opposite idea: browse and edit normally, then export the whole address book into whatever format the next tool actually reads — and import it back the same way.

What it does:

- Eleven export formats: vCard, a full .zip backup, Excel, CSV, OpenDocument, tab-separated, JSON, XML, LDIF and a printable HTML page.
- Import from anything: Reads vCard, CSV, Excel, OpenDocument, JSON, XML, LDIF and HTML — or a ZIP holding any mixture of them.
- Account-scoped: Choose exactly which accounts to include — the local phonebook, WhatsApp, or any other — each shown with its own count.
- Duplicate and gap finder: Finds people saved more than once, and entries that are missing a number or a name.
- Country code repair: Adds the correct country code to local numbers in bulk instead of one at a time.
- Backup history and undo: Scheduled backups, a restorable history, and a thirty-day bin for recently deleted contacts.

## Icon

- Store icon source: `/mnt/kencypher/Desktop/cypher-contacts/store-assets/icon-1024.png (1024 px; 512 and 4096 beside it)`
- Web copy: https://cypherstore.vercel.app/img/icons/cypher-contacts-256.png
- AppGallery wants 216 × 216 and Galaxy Store 512 × 512: scale the source down, never up.

## Screenshots

Desktop (portfolio/public/img/shots/, 2160 × 1350 PNG):

- `cypher-contacts-list.png` — The address book
- `cypher-contacts-transfer.png` — Export in eleven formats, or import them back
- `cypher-contacts-tools.png` — Clean-up tools: duplicates, incomplete contacts and country codes
- `cypher-contacts-settings.png` — Settings: language, date format and automatic backup

Phone (portfolio/public/img/shots/phone/, 1170 × 2532 PNG):

- `cypher-contacts-list.png` — The address book
- `cypher-contacts-detail.png` — A contact, with call and message
- `cypher-contacts-transfer.png` — Export in eleven formats
- `cypher-contacts-tools.png` — Clean-up tools
- `cypher-contacts-settings.png` — Settings and automatic backup

## Release notes — cypher-contacts-v1.18

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-contacts-v1.18

A contacts manager that lets your address book leave: eleven export formats,
duplicate finding and merging, a trash, scheduled backups, and a bulk
country-code rewrite.

## What's new in 1.18

Android, Windows and Linux, all on the same version.

- **Four tabs.** Export and Import are one Transfer tab now.
- **A directory with filters**, and on Windows and Linux a reading pane beside the list.
- **Edit a contact in one dialog**, and pick an export format from a plain list.
- **Delete in place.** The delete button asks once, right where you tapped, and a short note confirms it.
- **Dark mode follows your system**, and on Android the bars match the app.
- **Linux is an AppImage now.** Make it executable and run it.

## The files

| File | For |
|---|---|
| `CypherContacts-Setup-1.18.exe` | Windows 10/11 |
| `CypherContacts-1.18-x86_64.AppImage` | Linux x64 — `chmod +x`, then run it |
| `CypherContacts-1.18.apk` | Android 10+ |

---

**Free to use. Not open source.** Made by Kencypher (Muhammad Waleed Amjad),
sole author and copyright holder. Run it, share an unmodified copy, keep it
forever. Do not sell it, rebrand it, re-upload it, or publish it as your own.

The only true source for this software is **[Cypher Store](https://cypherstore.vercel.app/projects/cypher-contacts)**.
A copy from anywhere else is not one I published, and nothing about what is
inside it is guaranteed.

Every file here has a `.sha256` beside it. Windows may warn that the
publisher is unrecognised, because the installer is not code-signed — choose
**More info**, then **Run anyway**.
