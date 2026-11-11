#!/usr/bin/env bash
# Put Film Log on GitHub as ivyyy0601/film-log
set -euo pipefail
cd "$(dirname "$0")"
REPO="${1:-film-log}"
USER_GH="ivyyy0601"

if [ ! -d .git ]; then
  git init -q -b main
fi
git add index.html README.md deploy.sh .gitignore publish.sh
git commit -q -m "Film Log: color correction, instant-film frames and batch export" || echo "(nothing new to commit)"

if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  if ! git remote | grep -q origin; then
    gh repo create "$USER_GH/$REPO" --public --source . --remote origin --description "Color correction, instant-film frames and batch export for photos — ivyonearth.xyz/film" --homepage "https://ivyonearth.xyz/film/" --push
  else
    git push -u origin main
  fi
  echo "✓ https://github.com/$USER_GH/$REPO"
else
  echo
  echo "GitHub CLI (gh) isn't set up, so do these two steps:"
  echo "  1) Create an empty repo named '$REPO' at https://github.com/new  (no README, no .gitignore)"
  echo "  2) Run:"
  echo "     cd \"$(pwd)\" && git remote add origin https://github.com/$USER_GH/$REPO.git && git push -u origin main"
fi
