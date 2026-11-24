# mac-scripts

Login-time automation for the MacBook, shipped as a `.pkg`.

| Piece | What it does |
|---|---|
| `tz-per-user.sh` + `me.tz-per-user` daemon | every 10 s sets the system timezone from the console user (`working` → Europe/Podgorica, `alex` → Asia/Kuala_Lumpur) |
| `wg-user-switch` + daemon | on user switch: `working` gets only `wg1`; leaving `working` restores the previous tunnels |
| `me.focus.off` agent | when `working` logs out (also restart / shutdown; not fast user switching), runs the "Work Focus Off" shortcut |
| `wgup` / `wgdown` fish functions | swap between wg0 and wg1 by hand |

## Install
```
brew install --cask centralhardware/mac-scripts/mac-scripts
```
Updates come with `brew upgrade` (asks for sudo, reinstalls the pkg, reloads the daemons).
`brew uninstall --cask mac-scripts` unloads everything and removes the files.

## Release
Push a tag `vX.Y.Z` → GitHub Actions builds `mac-scripts-vX.Y.Z.pkg`, attaches it to a release, and bumps `Casks/mac-scripts.rb`.

WireGuard configs (`/etc/wireguard`, or `/opt/homebrew/etc/wireguard`) hold keys and stay out of this repo.
