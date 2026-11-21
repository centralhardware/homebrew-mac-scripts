cask "mac-scripts" do
  version "1.1.0"
  sha256 "7f43e39391c9a59cca141d9ba306940e3fa8e153c5eecf1f150ab76584cbfb29"

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
