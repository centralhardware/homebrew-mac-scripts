cask "mac-scripts" do
  version "1.2.1"
  sha256 "45d278fe81ba7089bb7bf5f0bfceed967b9e11eeef06cb3f0b5a05f5f04cb5cf"

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
