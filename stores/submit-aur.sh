#!/usr/bin/env bash
# Publishes or updates the AUR package of each AppImage release named here
# (default: the newest AppImage release of every app). Run it from your own
# machine once your AUR account has your SSH public key (AUR > My Account).
#
#   bash stores/submit-aur.sh
#   bash stores/submit-aur.sh cypher-music-v2.142
#
# Each package is committed as you (your git identity) and pushed to
# ssh://aur@aur.archlinux.org/<name>-appimage.git, which creates it the first time.
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
tags=("$@")
if [ ${#tags[@]} -eq 0 ]; then
  tags=(cypher-music-v2.141 cypher-contacts-v1.18 cypher-expenses-v3.11 cypher-bot-v1.131
        cypher-tools-v1.1.0 cypher-share-v3.1.1 cypher-visualizer-v1.1.0 cypher-cv-v1.0.0
        cypher-printers-v1.0.0 cypher-trainer-v1.0.0)
fi
work=$(mktemp -d)
trap 'rm -rf -- "$work"' EXIT

for tag in "${tags[@]}"; do
  out=$(GITHUB_TOKEN=${GITHUB_TOKEN:-$(gh auth token 2>/dev/null || true)} node "$here/make-aur.mjs" "$tag" --out "$work/new")
  echo "$out"
  case "$out" in Skipped*) continue ;; esac
  pkg=${out%%:*}
  git clone --quiet "ssh://aur@aur.archlinux.org/$pkg.git" "$work/$pkg"
  cp "$work/new/$pkg/PKGBUILD" "$work/new/$pkg/.SRCINFO" "$work/new/$pkg/LICENSE.txt" "$work/$pkg/"
  if [ -z "$(git -C "$work/$pkg" status --porcelain)" ]; then
    echo "$pkg: already up to date"; continue
  fi
  ver=$(sed -n 's/^\tpkgver = //p' "$work/$pkg/.SRCINFO")
  git -C "$work/$pkg" add PKGBUILD .SRCINFO LICENSE.txt
  git -C "$work/$pkg" commit --quiet -m "Update to $ver"
  git -C "$work/$pkg" push --quiet origin HEAD:master
  echo "$pkg $ver: https://aur.archlinux.org/packages/$pkg"
done
