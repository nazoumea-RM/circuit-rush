#!/usr/bin/env bash
# Generates the Android project files (once), sets the app name, internet permission and icons.
set -e
cd "$(dirname "$0")"

if [ ! -d android ]; then
  flutter create --platforms=android --org com.hlba --project-name circuit_rush .
  rm -rf test
fi

MANIFEST=android/app/src/main/AndroidManifest.xml
# App name shown under the icon
sed -i.bak 's/android:label="[^"]*"/android:label="Circuit Rush"/' "$MANIFEST"
# Internet permission (for the game fonts)
if ! grep -q 'android.permission.INTERNET' "$MANIFEST"; then
  sed -i.bak 's#<application#<uses-permission android:name="android.permission.INTERNET"/> <application#' "$MANIFEST"
fi
rm -f "$MANIFEST.bak"

flutter pub get
dart run flutter_launcher_icons
echo "Android project ready."
