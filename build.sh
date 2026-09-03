#!/usr/bin/env bash
set -euo pipefail

OUT="list.txt"
MY_FILTERS="workspace/my-filters.txt"
SOURCES="workspace/external/sources.txt"

{
  echo "! Title: Debloat the Web"
  echo "! Last updated: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
  echo "! Homepage: https://github.com/ccrrbbnn/Debloat-the-Web"
  echo ""

  grep -v '^\[Adblock' "$MY_FILTERS" | grep -v '^!'
  echo ""

  while IFS= read -r url; do
    [ -z "$url" ] && continue
    curl -sL "$url" | grep -v '^\[Adblock' | grep -v '^!'
    echo ""
  done < "$SOURCES"
} > "$OUT"

{
  head -n 4 "$OUT"
  tail -n +5 "$OUT" | awk 'NF' | awk '!seen[$0]++'
} > "${OUT}.tmp" && mv "${OUT}.tmp" "$OUT"
