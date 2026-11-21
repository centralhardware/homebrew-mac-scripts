#!/bin/bash
user=$(stat -f%Su /dev/console)
case "$user" in
  working)         tz="Europe/Podgorica" ;;
  alex) tz="Asia/Kuala_Lumpur" ;;
  *) exit 0 ;;
esac
cur=$(systemsetup -gettimezone | awk '{print $NF}')
[ "$cur" != "$tz" ] && systemsetup -settimezone "$tz" >/dev/null
