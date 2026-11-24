cask "mac-scripts" do
  version "1.2.0"
  sha256 "2bce26f11b88e5f04ee9445aadc714021b91958a5c7d4905f58acc8a00bc5f28"

  url "https://github.com/centralhardware/homebrew-mac-scripts/releases/download/v#{version}/mac-scripts-v#{version}.pkg"
  name "mac-scripts"
  desc "Login automation: per-user timezone, WireGuard switch, Focus off"
  homepage "https://github.com/centralhardware/homebrew-mac-scripts"

  pkg "mac-scripts-v#{version}.pkg"

  uninstall launchctl: [
              "me.tz-per-user",
              "me.centralhardware.wg-user-switch",
              "me.focus.off",
            ],
            pkgutil:   "me.centralhardware.mac-scripts"
end
