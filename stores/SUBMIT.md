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

## SourceForge (Windows, Linux and Android files)

`stores/apps.json` already names one project per app, after its slug (`cypher-music`, `cypher-contacts` and so on). All eleven names were free on 26 November 2026.

1. Make an account, then create each project under exactly that name. Cypher HR gets none.
2. Add an SSH public key under Account Settings › SSH Settings.
3. Upload the releases that already exist, from this folder:

   ```bash
   SF_USER=yourname bash stores/submit-sourceforge.sh
   ```

4. For every release after that, store the secrets: `SF_USER` (your user name), `SF_SSH_KEY` (the private key), `SF_KNOWN_HOSTS` (the output of `ssh-keyscan frs.sourceforge.net`, checked against SourceForge's published fingerprints) and, optionally, `SF_API_KEY` (Account › Release API key, which sets the default downloads). The workflow then uploads each new release.

Files already on SourceForge are never replaced.

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

Already filled in: descriptions, category, countries (all except the Chinese mainland, which needs a software copyright certificate), the privacy policy URL, privacy tags (no personal data collected), the AI declaration, reviewer notes and the age rating (Contacts and Tools 3+, Expenses 16+, which is Huawei's rating for finance apps). CYPHER-SHARE still needs its age rating and a check that its version page saved.

Left for you, because the upload boxes sit in a frame the browser tools cannot reach:

1. Sign back in to AppGallery Connect.
2. On each app's App information page: the 216 × 216 icon and three to five phone screenshots from `~/Desktop/builds/<app>/icon` and `screenshots/phone`. Save.
3. On each Draft version page: Manage packages › upload the APK from `~/Desktop/builds/<app>/Android`. Save Draft.
4. Submit only once https://cypherstore.vercel.app/privacy loads. It is in the portfolio `feature/privacy` branch, not pushed yet.

## Samsung Galaxy Store (Android)

1. Sign up in the Seller Portal (seller.samsungapps.com) as a private seller.
2. Same four apps as Huawei, same privacy URL. Icons are 512 × 512, in `~/Desktop/builds/<app>/icon`.
3. Check the minimum screenshot count when you get there: Share has only three phone screenshots.

## Flathub and Snap Store (Linux)

Nothing prepared, on purpose.

- **Flathub** does not accept manifests written or assisted by AI, or submission pull requests opened by AI tools, and it asks you to disclose AI-generated code inside the app. A Flathub listing means writing the Flatpak manifest and the pull request yourself.
- **Snap Store:** a `snapcraft.yaml` per app (Electron apps usually use the gnome extension) with strict confinement and the right plugs, a registered snap name and a store review.

## When a listing goes live

1. Add it to `portfolio/site/marketplaces.js`. The app page then shows it.
2. Change its row in `stores/REPORT.md` to Published, with the URL.
