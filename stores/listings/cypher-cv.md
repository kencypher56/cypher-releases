# Cypher CV — store listing

Every sentence below comes from the Cypher Store website (site/projects.apps.js) or the GitHub release. Nothing is added.

| Field | Value |
|---|---|
| Name | Cypher CV |
| Short description | Scores your CV for applicant tracking systems out of 10, then improves and tailors it, offline. |
| Website | https://cypherstore.vercel.app/projects/cypher-cv |
| Licence | Proprietary freeware, free of charge — https://github.com/kencypher56/cypher-releases/blob/master/LICENSE.txt |
| Developer | Muhammad Waleed Amjad (Kencypher), https://github.com/kencypher56 |
| Support | https://github.com/kencypher56/cypher-releases/issues |
| Privacy policy | **None published yet.** Huawei AppGallery and Samsung Galaxy Store require a privacy policy URL. |
| Suggested category | Business / Office |
| Requirements | Windows 10/11 (64-bit); Linux (x64) |
| Windows testing | Its README says the Windows build has been tested only under Wine, not yet on real Windows. |
| Price | Free; no ads (as the website says) |

## Versions and files

| Platform | File | Version |
|---|---|---|
| Windows (portable) | CypherCV-1.0.0.exe | 1.0.0 |
| Linux (appimage) | CypherCV-1.0.0-x86_64.AppImage | 1.0.0 |

## Long description

Cypher CV reads your CV the way applicant tracking systems do and scores it out of 10, with every point explained. It fixes what it can from your own words, asks you for the numbers and facts only you know, tailors the CV to a job without inventing skills, and exports Word and PDF files that keep your formatting. Everything runs on your computer: no account, no API key, no upload.

What it does:

- An ATS score out of 10: Seven weighted categories, from readability and structure to achievements and contact details, each with its own score and the issues behind it.
- Fixes made from your own words: Weak openers, long bullets, unexplained abbreviations and paragraphs that should be bullets are reshaped from what the CV already says. Untick any fix you do not want.
- Questions only you can answer: Where a bullet needs a real number or your own part in the work, it asks. Your answer goes in exactly as you wrote it, and nothing is invented.
- Before and after, side by side: Every new version sits next to the one it came from, each change numbered with what was wrong and why it changed, and every old issue marked fixed, improved or still open.
- Tailored to the job: Paste a job description and it lines the CV up against it, without adding skills you do not have.
- Word and PDF that keep your formatting: Exports keep headings, bold phrases and links, and every export is read back to check. Pick a template, font and page size, or keep the plain ATS standard.

## Icon

- Store icon source: `/mnt/kencypher/Desktop/cypher cv/build/icon.png (512 px)`
- Web copy: https://cypherstore.vercel.app/img/icons/cypher-cv-256.png
- AppGallery wants 216 × 216 and Galaxy Store 512 × 512: scale the source down, never up.

## Screenshots

Desktop (portfolio/public/img/shots/, 2160 × 1350 PNG):

- `cypher-cv-score.png` — The ATS score, each category and the issues to fix
- `cypher-cv-improve.png` — Automatic fixes, and questions only you can answer
- `cypher-cv-compare.png` — Before and after, with every old issue tracked

## Release notes — cypher-cv-v1.0.0

https://github.com/kencypher56/cypher-releases/releases/tag/cypher-cv-v1.0.0

An offline CV checker. It scores a CV for ATS readiness out of 10 with every point explained, improves it from your own words, tailors it to a job and exports Word and PDF.

## What's in 1.0.0

First release.

- **ATS score out of 10**, with every point explained.
- **Improve**: automatic fixes made from the CV's own words (weak openers, long bullets split, abbreviations spelled out), plus questions for facts only you know. Your answers go in exactly as written.
- **Side by side**: every new version is shown next to the one it came from, each change numbered with what was wrong and why it changed.
- **CV Editor**: edit any field, or add a company, project, certification, achievement or a missing section.
- **Apply Job**: tailor the CV to a job description without inventing skills.
- **Export** to DOCX and PDF that keep the CV's headings, bold phrases and links.

No accounts, no API keys and no network calls.

## Run (Windows 10/11, 64-bit)

`CypherCV-1.0.0.exe` is one portable file: download it and run it. Nothing is installed. It unpacks to a temporary folder each time it starts, so the first launch takes a few seconds.

## Run (Linux x64)

    chmod +x CypherCV-1.0.0-x86_64.AppImage
    ./CypherCV-1.0.0-x86_64.AppImage

Each file has a matching `.sha256`.
