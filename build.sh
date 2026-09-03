#!/usr/bin/env bash
set -euo pipefail

OUT="list.txt"
MY_FILTERS="workspace/my-filters.txt"
SOURCES="workspace/external/sources.txt"

{
  echo "[Adblock Plus 2.0]"
  echo "! Title: Debloat the Web"
  echo "! Last updated: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
  echo "! Homepage: https://github.com/ccrrbbnn/Debloat-the-Web"
  echo ""

  grep -v '^\[Adblock' "$MY_FILTERS"
  echo ""

  while IFS= read -r url; do
    [ -z "$url" ] && continue
    curl -sL "$url" | grep -v '^\[Adblock'
    echo ""
  done < "$SOURCES"
} > "$OUT"

awk '!seen[$0]++ || /^!/ || /^\[/ || /^$/' "$OUT" > "${OUT}.tmp" && mv "${OUT}.tmp" "$OUT"
