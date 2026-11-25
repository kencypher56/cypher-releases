#!/usr/bin/env bash
# Opens one pull request per new package at microsoft/winget-pkgs, from your
# fork, with the manifests in stores/winget. Safe to run again: it picks up
# where a run stopped, brings open pull requests up to date with the files
# here, and skips versions winget-pkgs already has. Later versions follow
# from the "Publish to stores" workflow once WINGET_TOKEN is set.
#
#   bash stores/submit-winget.sh               # every package in stores/winget
#   bash stores/submit-winget.sh CypherMusic   # just these
#
# Needs gh signed in as you. On your first pull request the Microsoft CLA bot
# asks you to reply "@microsoft-github-policy-service agree"; until then the
# pull requests wait with the Needs-CLA label.
set -uo pipefail

here=$(cd "$(dirname "$0")" && pwd)
me=$(gh api user --jq .login) || exit 1
# Packages whose exe is on hold in apps.json go only when named on the command line.
held=$(node -e 'const a=require(process.argv[1]).apps; for (const k in a) if (a[k].exe?.hold && a[k].wingetId) console.log(a[k].wingetId.split(".")[1])' "$here/apps.json") || exit 1

# GitHub turns away bursts of writes; try a call up to five times, waiting longer each time.
retry() {
  local i
  for i in 1 2 3 4 5; do
    "$@" && return 0
    echo "  retrying in $((i * 15)) s: ${*:1:4}" >&2
    sleep $((i * 15))
  done
  return 1
}

if ! gh api "repos/$me/winget-pkgs" --silent 2>/dev/null; then
  gh repo fork microsoft/winget-pkgs --clone=false || exit 1
  until gh api "repos/$me/winget-pkgs" --silent 2>/dev/null; do sleep 5; done
fi
retry gh repo sync "$me/winget-pkgs" --branch master || exit 1
base=$(gh api "repos/$me/winget-pkgs/git/ref/heads/master" --jq .object.sha) || exit 1

# Open pull requests from this exact branch. The REST filter is exact and
# immediate; gh pr list goes through search, which lags new pull requests.
open_prs() { gh api "repos/microsoft/winget-pkgs/pulls?state=open&head=$me:$1" --jq length; }
# Another run may open it between tries, so look again before each attempt.
create_pr() {
  local branch=$1; shift
  [ "$(open_prs "$branch")" = 0 ] || return 0
  gh pr create --repo microsoft/winget-pkgs --base master --head "$me:$branch" "$@"
}

submit() {
  local dir=$1 ver pkg id path branch f name sha old
  ver=$(basename "$dir"); pkg=$(basename "$(dirname "$dir")"); id="Kencypher.$pkg"
  path="manifests/k/Kencypher/$pkg/$ver"; branch="$id-$ver"

  if gh api "repos/microsoft/winget-pkgs/contents/$path" --silent 2>/dev/null; then
    echo "$id $ver: already in winget-pkgs"; return 0
  fi
  if ! gh api "repos/$me/winget-pkgs/git/ref/heads/$branch" --silent 2>/dev/null; then
    retry gh api "repos/$me/winget-pkgs/git/refs" -f ref="refs/heads/$branch" -f sha="$base" --silent || return 1
  fi
  for f in "$dir"/*.yaml; do
    name=$(basename "$f")
    sha=$(gh api "repos/$me/winget-pkgs/contents/$path/$name?ref=$branch" --jq .sha 2>/dev/null) || sha=
    if [ -n "$sha" ]; then
      old=$(gh api "repos/$me/winget-pkgs/contents/$path/$name?ref=$branch" --jq .content | base64 -d)
      [ "$old" = "$(cat "$f")" ] && continue
      retry gh api -X PUT "repos/$me/winget-pkgs/contents/$path/$name" --silent -f branch="$branch" -f sha="$sha" \
        -f message="Update $id $ver: $name" -f content="$(base64 -w0 "$f")" || return 1
    else
      retry gh api -X PUT "repos/$me/winget-pkgs/contents/$path/$name" --silent -f branch="$branch" \
        -f message="New package: $id version $ver" -f content="$(base64 -w0 "$f")" || return 1
    fi
  done
  if [ "$(open_prs "$branch")" != 0 ]; then
    echo "$id $ver: pull request already open, files brought up to date"; return 0
  fi
  retry create_pr "$branch" --title "New package: $id version $ver" \
    --body "New package $id $ver, published by its author, Muhammad Waleed Amjad (Kencypher), at https://github.com/kencypher56/cypher-releases.

- The three manifests pass the 1.12.0 JSON schemas.
- InstallerSha256 matches the SHA-256 GitHub reports for the release file.
- Not yet checked with \`winget validate\` or a local \`winget install --manifest\` on Windows." || return 1
}

failed=()
for dir in "$here"/winget/manifests/k/Kencypher/*/*/; do
  dir=${dir%/}; pkg=$(basename "$(dirname "$dir")")
  if [ $# -gt 0 ] && [[ " $* " != *" $pkg "* ]]; then continue; fi
  if [ $# -eq 0 ] && grep -qx "$pkg" <<<"$held"; then echo "Kencypher.$pkg is on hold (see stores/apps.json); name it to send it anyway"; continue; fi
  submit "$dir" || failed+=("Kencypher.$pkg")
  sleep 20
done

if [ ${#failed[@]} -gt 0 ]; then
  echo "Failed: ${failed[*]}. Run the script again; it resumes where it stopped." >&2
  exit 1
fi
echo "Done. Your pull requests: https://github.com/microsoft/winget-pkgs/pulls/$me"
