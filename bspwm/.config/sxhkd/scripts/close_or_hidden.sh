#/bin/bash

set -euo pipefail

focused_node=$(bspc query -N -n focused 2>/dev/null || true)

if [[ -z "$focused_node" ]]; then
  exit 0
fi

class=$(xprop -id "$focused_node" WM_CLASS 2>/dev/null | awk -F '"' '{print $4}' || echo "")

if [[ -z "$class" ]]; then
  bspc node -c
  exit 0
fi

should_hide=false

case "$class" in
org.mozilla.Thunderbird | thunderbird)
  should_hide=true
  ;;
esac

if $should_hide; then
  bspc node focused -g hidden=on
else
  bspc node -c
fi
