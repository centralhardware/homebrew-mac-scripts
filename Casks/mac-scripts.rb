cask "mac-scripts" do
  version "1.2.2"
  sha256 "7e0c98405d878ca55f63dde137760e14fd954635354fd3879424fa6d3473f5d6"

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
