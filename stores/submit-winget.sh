#!/usr/bin/env bash
# Opens one pull request per new package at microsoft/winget-pkgs, from your
# fork, with the manifests in stores/winget. Only the first version of each
# package goes in this way; later ones follow from the "Publish to stores"
# workflow once WINGET_TOKEN is set.
#
#   bash stores/submit-winget.sh               # every package in stores/winget
#   bash stores/submit-winget.sh CypherMusic   # just these
#
# Needs gh signed in as you. Your first pull request there asks you to sign
# Microsoft's contributor licence agreement in a comment.
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
me=$(gh api user --jq .login)
# Packages whose exe is on hold in apps.json go only when named on the command line.
held=$(node -e 'const a=require(process.argv[1]).apps; for (const k in a) if (a[k].exe?.hold && a[k].wingetId) console.log(a[k].wingetId.split(".")[1])' "$here/apps.json")

if ! gh api "repos/$me/winget-pkgs" --silent 2>/dev/null; then
  gh repo fork microsoft/winget-pkgs --clone=false
  until gh api "repos/$me/winget-pkgs" --silent 2>/dev/null; do sleep 5; done
fi
gh repo sync "$me/winget-pkgs" --branch master
base=$(gh api "repos/$me/winget-pkgs/git/ref/heads/master" --jq .object.sha)

for dir in "$here"/winget/manifests/k/Kencypher/*/*/; do
  dir=${dir%/}; ver=$(basename "$dir"); pkg=$(basename "$(dirname "$dir")"); id="Kencypher.$pkg"
  if [ $# -gt 0 ] && [[ " $* " != *" $pkg "* ]]; then continue; fi
  if [ $# -eq 0 ] && grep -qx "$pkg" <<<"$held"; then echo "$id is on hold (see stores/apps.json); name it to send it anyway"; continue; fi
  path="manifests/k/Kencypher/$pkg/$ver"

  if gh api "repos/microsoft/winget-pkgs/contents/$path" --silent 2>/dev/null; then
    echo "$id $ver is already in winget-pkgs"; continue
  fi
  open=$(gh pr list --repo microsoft/winget-pkgs --state open --search "$id $ver in:title" --json number --jq length)
  if [ "$open" != 0 ]; then echo "$id $ver already has an open pull request"; continue; fi

  branch="$id-$ver"
  gh api "repos/$me/winget-pkgs/git/refs" -f ref="refs/heads/$branch" -f sha="$base" --silent
  for f in "$dir"/*.yaml; do
    gh api -X PUT "repos/$me/winget-pkgs/contents/$path/$(basename "$f")" --silent \
      -f message="New package: $id version $ver" -f branch="$branch" -f content="$(base64 -w0 "$f")"
  done
  gh pr create --repo microsoft/winget-pkgs --base master --head "$me:$branch" \
    --title "New package: $id version $ver" \
    --body "New package $id $ver, published by its author at https://github.com/kencypher56/cypher-releases.

- The three manifests pass the 1.12.0 JSON schemas.
- InstallerSha256 matches the SHA-256 GitHub reports for the release file.
- Not yet checked with \`winget validate\` or a local \`winget install --manifest\` on Windows."
done
