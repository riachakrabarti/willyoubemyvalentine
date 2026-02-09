#!/bin/bash
# Run this after adding/removing photos to update the manifest.
# Usage: ./update-photos.sh

cd "$(dirname "$0")/photos"

# Find all image files and build a JSON array of filenames
echo "[" > photos.json.tmp
first=true
for f in *.jpg *.jpeg *.png *.webp *.gif *.JPG *.JPEG *.PNG *.WEBP; do
  [ -f "$f" ] || continue
  [ "$f" = "photos.json" ] && continue
  if [ "$first" = true ]; then
    first=false
  else
    printf ",\n" >> photos.json.tmp
  fi
  printf '  "%s"' "$f" >> photos.json.tmp
done
echo "" >> photos.json.tmp
echo "]" >> photos.json.tmp

mv photos.json.tmp photos.json
echo "Updated photos.json with $(grep -c '"' photos.json | awk '{print int($1/1)}') photos"
cat photos.json
