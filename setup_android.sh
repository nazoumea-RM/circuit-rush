#!/usr/bin/env bash
# Generates the Android project files (once), sets the app name, removes the internet
# permission (the game runs fully offline), bundles the fonts and creates the icons.
set -e
cd "$(dirname "$0")"

# 1) Fonts bundled inside the app (Open Font License), so no internet is needed.
FONTS=assets/game/fonts
mkdir -p "$FONTS"
RAW=https://raw.githubusercontent.com/google/fonts/main/ofl
[ -s "$FONTS/Lalezar-Regular.ttf" ] || curl -fsSL -o "$FONTS/Lalezar-Regular.ttf" "$RAW/lalezar/Lalezar-Regular.ttf" || echo "warning: Lalezar font not downloaded"
[ -s "$FONTS/Cairo.ttf" ]           || curl -fsSL -o "$FONTS/Cairo.ttf" "$RAW/cairo/Cairo%5Bslnt%2Cwght%5D.ttf" || echo "warning: Cairo font not downloaded"
[ -s "$FONTS/OFL.txt" ]             || curl -fsSL -o "$FONTS/OFL.txt" "$RAW/cairo/OFL.txt" || echo "warning: font licence not downloaded"
# keep the folder non-empty so the asset declaration in pubspec.yaml is always valid
[ -n "$(ls -A "$FONTS")" ] || echo "fonts" > "$FONTS/README.txt"

# 2) Android project
if [ ! -d android ]; then
  flutter create --platforms=android --org com.hlba --project-name circuit_rush .
  rm -rf test
fi

MANIFEST=android/app/src/main/AndroidManifest.xml
# App name shown under the icon
sed -i.bak 's/android:label="[^"]*"/android:label="Circuit Rush"/' "$MANIFEST"
# Make sure the release app has NO internet permission, even if a library asks for it
if ! grep -q 'xmlns:tools=' "$MANIFEST"; then
  sed -i.bak 's#<manifest xmlns:android="http://schemas.android.com/apk/res/android"#<manifest xmlns:android="http://schemas.android.com/apk/res/android" xmlns:tools="http://schemas.android.com/tools"#' "$MANIFEST"
fi
sed -i.bak '/android.permission.INTERNET/d' "$MANIFEST"
sed -i.bak 's#<application#<uses-permission android:name="android.permission.INTERNET" tools:node="remove"/> <application#' "$MANIFEST"
rm -f "$MANIFEST.bak"

flutter pub get
dart run flutter_launcher_icons
echo "Android project ready."
