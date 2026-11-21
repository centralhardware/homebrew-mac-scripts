# mac-scripts

Login-time automation for the MacBook, shipped as a `.pkg`.

| Piece | What it does |
|---|---|
| `tz-per-user.sh` + `me.tz-per-user` daemon | every 10 s sets the system timezone from the console user (`working` → Europe/Podgorica, `alex` → Asia/Kuala_Lumpur) |
| `wg-user-switch` + daemon | on user switch: `working` gets only `wg1`; leaving `working` restores the previous tunnels |
| `me.focus.off` agent | at login of any user except `working`, runs the "Work Focus Off" shortcut |
| `wgup` / `wgdown` fish functions | swap between wg0 and wg1 by hand |

## Release
Push a tag `vX.Y.Z` → GitHub Actions builds `mac-scripts-vX.Y.Z.pkg` and attaches it to a release. 

## First install (once)
Download the pkg from the latest release and `sudo installer -pkg mac-scripts-*.pkg -target /`.
WireGuard configs (`/etc/wireguard`, or `/opt/homebrew/etc/wireguard`) hold keys and stay out of this repo.
