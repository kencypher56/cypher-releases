# What is left to do, store by store

Everything that can be prepared without your accounts is here. Accounts, terms, passwords, API keys and publishing are yours. Store secrets only in GitHub Actions secrets: `gh secret set NAME --repo kencypher56/cypher-releases` asks for the value without echoing it.

Listing text, icons, screenshots and release notes for each app: `stores/listings/<app>.md`. Status of every app on every store: `stores/REPORT.md`.

Every listing names you as Muhammad Waleed Amjad (Kencypher). To keep an app's Windows build out of the stores later, add `"hold": "<reason>"` to its `exe` entry in `stores/apps.json`.

## WinGet (Windows)

1. Done on 2026-11-25: all nine pull requests are open (links in `stores/REPORT.md`). For a new app, run the script again. It is safe to repeat: it resumes where it stopped and brings open pull requests up to date.

   ```bash
   bash stores/submit-winget.sh
   ```

2. Sign Microsoft's CLA once, by commenting this on any one of your pull requests:

   ```text
   @microsoft-github-policy-service agree
   ```

   Until then they wait with the `Needs-CLA` label. After that, validation runs and a moderator merges them.
3. After the first versions are merged, later releases follow on their own. Create a *classic* token with `public_repo` and `workflow` scopes, then:

   ```bash
   gh secret set WINGET_TOKEN --repo kencypher56/cypher-releases
   ```

## Chocolatey (Windows)

1. Make an account at community.chocolatey.org and copy your API key from the account page.
2. Store it, then send all nine packages through the workflow:

   ```bash
   gh secret set CHOCO_API_KEY --repo kencypher56/cypher-releases
   ```

   ```bash
   for t in cypher-music-v2.141 cypher-contacts-v1.18 cypher-expenses-v3.11 cypher-bot-v1.123 cypher-tools-v1.1.0 cypher-share-v3.1.0 cypher-visualizer-v1.1.0 cypher-cv-v1.0.0 cypher-printers-v1.0.0; do gh workflow run "Publish to stores" --repo kencypher56/cypher-releases -f tag=$t; done
   ```

3. New packages wait for human moderation before they are public.

## SourceForge (not used)

SourceForge's Terms of Use (section 10) require everything uploaded through its file release system to be licensed under an OSI-approved open-source licence, granted to Slashdot Media and every downloader. The Cypher apps are proprietary freeware, so no project was created. `stores/submit-sourceforge.sh` and the workflow's SourceForge step stay idle while the SF_* secrets do not exist; use them only if an app becomes open source.

## AUR (Linux)

Each app with an AppImage gets a `<slug>-appimage` package that installs the AppImage unchanged in `/opt`, with a command, a menu entry and an icon. All ten were test-built with makepkg.

1. Make an AUR account at aur.archlinux.org and add your SSH public key under My Account.
2. Publish all ten from this folder (it commits as your git identity and pushes):

   ```bash
   bash stores/submit-aur.sh
   ```

3. For later releases, store `AUR_SSH_KEY` and `AUR_KNOWN_HOSTS` (the output of `ssh-keyscan aur.archlinux.org`, checked against the fingerprints on aur.archlinux.org). The workflow then updates the package.

## Uptodown (Windows and Android)

There is no upload API. Sign up in the Developers Console (en.uptodown.com/developers-console), then upload each app's `.exe` and `.apk` by hand, with the text from its listing file.

## Huawei AppGallery (Android)

Drafts exist for Cypher Contacts, Cypher Expenses, Cypher Tools and CYPHER-SHARE (Huawei wants the name inside the APK, and Share's is CYPHER-SHARE). Music (YouTube downloads), BOT (celebrity voices) and Store (installs other apps) are left out.

All four drafts are complete: descriptions, category, compatible device (phone), icon, screenshots, APK (SHA-256 checked before upload), countries (all except the Chinese mainland, which needs a software copyright certificate), the privacy policy URL, privacy tags (no personal data collected), the AI declaration, reviewer notes and the age rating (Contacts, Tools and Share 3+, Expenses 16+, which is Huawei's rating for finance apps).

All four were submitted for review on 2026-11-27 and show Reviewing. Nothing is left for you until Huawei replies; answer any reviewer question in AppGallery Connect.

## Samsung Galaxy Store (skipped)

Skipped at your request on 2026-11-27: the Seller Portal sign-up asked for fees.

## Flathub and Snap Store (Linux)

Nothing prepared, on purpose.

- **Flathub** does not accept manifests written or assisted by AI, or submission pull requests opened by AI tools, and it asks you to disclose AI-generated code inside the app. A Flathub listing means writing the Flatpak manifest and the pull request yourself.
- **Snap Store:** a `snapcraft.yaml` per app (Electron apps usually use the gnome extension) with strict confinement and the right plugs, a registered snap name and a store review.

## When a listing goes live

1. Add it to `portfolio/site/marketplaces.js`. The app page then shows it.
2. Change its row in `stores/REPORT.md` to Published, with the URL.
