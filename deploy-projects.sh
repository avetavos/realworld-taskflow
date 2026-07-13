#!/usr/bin/env bash
# Deploys the shared "projects.avetavos.com" Cloudflare worker, which serves every
# Real-World Project by path (/taskflow/*, /devblog/*, ...). Each project builds in
# its own repo; this script stages them all under .cf-assets/<slug>/ and deploys once.
# Add a new line per project as more come online.
set -euo pipefail
ROOT="$HOME/Develops"
cd "$ROOT/realworld-taskflow"
rm -rf .cf-assets

# taskflow (this repo)
npm run build
mkdir -p .cf-assets/taskflow && cp -R dist/. .cf-assets/taskflow/

# devblog
( cd "$ROOT/realworld-devblog" && npm run build )
mkdir -p .cf-assets/devblog && cp -R "$ROOT/realworld-devblog/dist/." .cf-assets/devblog/

npx wrangler deploy
