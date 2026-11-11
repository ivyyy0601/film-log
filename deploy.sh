#!/usr/bin/env bash
# Deploy Film Log to https://ivyonearth.xyz/film/  (server 138.199.208.197)
set -euo pipefail
HOST="${1:-root@138.199.208.197}"
HERE="$(cd "$(dirname "$0")" && pwd)"

echo "→ Uploading index.html ..."
scp -q "$HERE/index.html" "$HOST:/tmp/filmlog-index.html"

ssh "$HOST" 'bash -s' <<'REMOTE'
set -euo pipefail
WEB=/var/www/film
mkdir -p "$WEB"
cp /tmp/filmlog-index.html "$WEB/index.html"; rm -f /tmp/filmlog-index.html
chmod 755 /var/www "$WEB"; chmod 644 "$WEB/index.html"
echo "   page installed at $WEB/index.html"

CF=/etc/caddy/Caddyfile
if grep -q 'handle_path /film/\*' "$CF"; then
  echo "   /film route already in Caddyfile — page updated, done."; exit 0
fi
if ! grep -q '^[[:space:]]*redir /nyc /nyc/ permanent' "$CF"; then
  echo "!! Couldn't find the /nyc block in $CF — route not added."; exit 1
fi
cp "$CF" "$CF.bak-filmlog"
awk 'done==0 && /^[[:space:]]*redir \/nyc \/nyc\/ permanent/ {
  print "    redir /film /film/ permanent"
  print "    handle_path /film/* {"
  print "        root * /var/www/film"
  print "        file_server"
  print "    }"
  done=1
} {print}' "$CF.bak-filmlog" > "$CF"
if caddy validate --config "$CF" --adapter caddyfile >/dev/null 2>&1; then
  systemctl reload caddy
  echo "   /film route added, Caddy reloaded (backup: $CF.bak-filmlog)"
else
  cp "$CF.bak-filmlog" "$CF"
  echo "!! Caddy rejected the change — original config restored."; exit 1
fi
REMOTE
echo "✓ Done → https://ivyonearth.xyz/film/"
