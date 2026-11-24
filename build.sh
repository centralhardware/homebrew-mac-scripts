#!/bin/bash
# Build mac-scripts-<version>.pkg. Usage: ./build.sh <version>
set -euo pipefail
V=${1:?version}
root=$(mktemp -d)
install -d "$root/usr/local/bin" "$root/Library/LaunchDaemons" "$root/Library/LaunchAgents" \
  "$root/usr/local/share/mac-scripts/daemons" "$root/usr/local/share/mac-scripts/fish"
install -m 755 bin/* "$root/usr/local/bin/"
install -m 644 LaunchDaemons/*.plist "$root/Library/LaunchDaemons/"
install -m 644 LaunchDaemons/*.plist "$root/usr/local/share/mac-scripts/daemons/"
install -m 644 LaunchAgents/*.plist "$root/Library/LaunchAgents/"
install -m 644 fish/*.fish "$root/usr/local/share/mac-scripts/fish/"
echo "$V" > "$root/usr/local/share/mac-scripts/VERSION"
pkgbuild --root "$root" --scripts scripts --identifier me.centralhardware.mac-scripts \
  --version "${V#v}" --ownership recommended "mac-scripts-$V.pkg"
