#!/usr/bin/env bash
set -euo pipefail

OUT="dist/combined.txt"
mkdir -p dist

{
  echo "[Adblock Plus 2.0]"
  echo "! Title: Debloat the Web"
  echo "! Last updated: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
  echo "! Homepage: https://github.com/ccrrbbnn/Debloat-the-Web"
  echo ""

  grep -v '^\[Adblock' custom/brave-annoyances.txt
  echo ""

  while IFS= read -r url; do
    [ -z "$url" ] && continue
    curl -sL "$url" | grep -v '^\[Adblock'
    echo ""
  done < sources.txt
} > "$OUT"

awk '!seen[$0]++ || /^!/ || /^\[/ || /^$/' "$OUT" > "${OUT}.tmp" && mv "${OUT}.tmp" "$OUT"
