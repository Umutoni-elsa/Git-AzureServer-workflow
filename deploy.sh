#!/bin/bash
set -e

REPO=~/git-workflow-demo
WEB=/var/www/html
LOG=~/deploy.log

cd "$REPO"
echo "$(date '+%F %T') deploy started" >> "$LOG"

git fetch origin main
git reset --hard origin/main

sudo rsync -a --delete \
  --exclude='.git' \
  --exclude='.github' \
  --exclude='deploy.sh' \
  --exclude='README.md' \
  "$REPO"/ "$WEB"/
sudo chown -R www-data:www-data "$WEB"

echo "$(date '+%F %T') deployed $(git rev-parse --short HEAD)" >> "$LOG"
