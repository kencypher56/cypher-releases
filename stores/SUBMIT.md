# What is left to do, store by store

Everything that can be prepared without your accounts is here. Accounts, terms, passwords, API keys and publishing are yours. Store secrets only in GitHub Actions secrets: `gh secret set NAME --repo kencypher56/cypher-releases` asks for the value without echoing it.

Listing text, icons, screenshots and release notes for each app: `stores/listings/<app>.md`. Status of every app on every store: `stores/REPORT.md`.

## WinGet (Windows)

1. Open the first pull request for every package. This forks microsoft/winget-pkgs if you have no fork yet:

   ```bash
   bash stores/submit-winget.sh
   ```

2. On your first pull request, the Microsoft CLA bot asks you to agree in a comment. Do that, then wait for validation and a moderator.
3. After the first versions are merged, later releases follow on their own. Create a *classic* token with `public_repo` and `workflow` scopes, then:

   ```bash
   gh secret set WINGET_TOKEN --repo kencypher56/cypher-releases
   ```

## Chocolatey (Windows)

1. Make an account at community.chocolatey.org and copy your API key from the account page.
2. Store it, then send the eight packages through the workflow:

   ```bash
   gh secret set CHOCO_API_KEY --repo kencypher56/cypher-releases
   ```

   ```bash
   for t in cypher-music-v2.141 cypher-contacts-v1.18 cypher-expenses-v3.11 cypher-tools-v1.1.0 cypher-share-v3.1.0 cypher-visualizer-v1.1.0 cypher-cv-v1.0.0 cypher-printers-v1.0.0; do gh workflow run "Publish to stores" --repo kencypher56/cypher-releases -f tag=$t; done
   ```

3. New packages wait for human moderation before they are public.

## SourceForge (Windows and Linux files)

1. Make an account, then one project per app.
2. Put each project's short name in the `sourceforge` field of `stores/apps.json`.
3. Add an SSH public key under Account Settings › SSH Settings.
4. Run `ssh-keyscan frs.sourceforge.net` and check its fingerprints against SourceForge's documentation.
5. Store the secrets: `SF_USER` (your user name), `SF_SSH_KEY` (the private key), `SF_KNOWN_HOSTS` (the checked keyscan output) and, optionally, `SF_API_KEY` (Account › Release API key, which sets the default downloads).
6. Run the workflow for each tag, as in the Chocolatey loop, adding `cypher-share-v3.1.1` and `cypher-trainer-v1.0.0`.

Files already on SourceForge are never replaced.

## Uptodown (Windows and Android)

There is no upload API. Sign up in the Developers Console (en.uptodown.com/developers-console), then upload each app's `.exe` and `.apk` by hand, with the text from its listing file.

## Huawei AppGallery and Samsung Galaxy Store (Android)

1. Both require a **privacy policy URL**, and the website has none. It has to say what each app actually collects and sends, which only you can state. Publish it first.
2. Then register: Huawei needs identity verification for a personal account. Samsung uses the Seller Portal.
3. Upload the APK and fill in the content rating questionnaire. Expect questions about MANAGE_EXTERNAL_STORAGE (Music, Share) and the contacts permissions (Contacts).
4. Leave out Cypher Store: it installs other apps, which these stores normally refuse.
5. AppGallery icons are 216 × 216 and Galaxy Store icons 512 × 512. Scale the sources named in the listing files down, never up.

## Aptoide (Android)

Check Aptoide Connect's price before you sign up: a third-party guide says it is a paid subscription. Uploads are APKs up to 2 GB.

## Flathub and Snap Store (Linux)

Neither takes an AppImage, so nothing was submitted to them. Each app would need:

- **Flathub:** a Flatpak manifest wrapping the Electron build, AppStream metainfo with screenshots, a desktop file, and an app ID you can prove you own (for example `io.github.kencypher56.CypherMusic`). Then a pull request to flathub/flathub and their review.
- **Snap Store:** a `snapcraft.yaml` (Electron apps usually use the gnome extension) with strict confinement and the right plugs (home, removable-media, network, audio-playback). Then a registered snap name and a store review.

Either way that is a packaging project per app, not a re-upload.

## When a listing goes live

1. Add it to `portfolio/site/marketplaces.js`. The app page then shows it.
2. Change its row in `stores/REPORT.md` to Published, with the URL.
