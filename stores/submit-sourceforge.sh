#!/usr/bin/env bash
# Uploads the files of each release named here (default: the newest release of
# every app) to that app's SourceForge project, in a folder named after the
# version. A file already on SourceForge is never replaced. New releases after
# this go up through the "Publish to stores" workflow.
#
# Before the first run: create each project on SourceForge under the name in the
# "sourceforge" field of stores/apps.json, and add your SSH public key to your
# SourceForge account (Account > SSH Settings).
#
#   SF_USER=yourname bash stores/submit-sourceforge.sh
#   SF_USER=yourname bash stores/submit-sourceforge.sh cypher-music-v2.142
set -euo pipefail
shopt -s nullglob

user=${SF_USER:?Set SF_USER to your SourceForge user name}
here=$(cd "$(dirname "$0")" && pwd)
tags=("$@")
if [ ${#tags[@]} -eq 0 ]; then
  tags=(cypher-music-v2.141 cypher-contacts-v1.18 cypher-expenses-v3.11 cypher-bot-v1.131
        cypher-tools-v1.1.0 cypher-share-v3.1.0 cypher-share-v3.1.1 cypher-visualizer-v1.1.0
        cypher-cv-v1.0.0 cypher-printers-v1.0.0 cypher-trainer-v1.0.0 cypher-store-v1.4.1)
fi
work=$(mktemp -d)
trap 'rm -rf -- "$work"' EXIT

field() { node -e 'const a=require(process.argv[1]).apps[process.argv[2]]||{}; process.stdout.write(String(process.argv[3].split(".").reduce((o,k)=>o?.[k],a)??""))' "$here/apps.json" "$1" "$2"; }

for tag in "${tags[@]}"; do
  slug=${tag%-v*}; version=${tag##*-v}
  project=$(field "$slug" sourceforge)
  if [ -z "$project" ]; then echo "Skipped $tag: no SourceForge project in stores/apps.json"; continue; fi
  dir="$work/$tag"; mkdir -p "$dir"
  gh release download "$tag" --repo kencypher56/cypher-releases --dir "$dir" \
    --pattern '*.exe' --pattern '*.AppImage' --pattern '*.apk' --pattern '*.sha256'
  # An exe on hold in stores/apps.json stays off SourceForge, as in the workflow.
  if [ -n "$(field "$slug" exe.hold)" ]; then rm -f "$dir"/*.exe "$dir"/*.exe.sha256; fi
  (cd "$dir" && for f in *.sha256; do sha256sum -c "$f"; done)
  rsync -av --mkpath --ignore-existing "$dir/" "$user@frs.sourceforge.net:/home/frs/project/$project/$version/"
  echo "$tag: https://sourceforge.net/projects/$project/files/$version/"
done
