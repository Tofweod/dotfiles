#! /bin/sh

wait_for_class() {
  class="$1"

  bspc subscribe node_add | while read -r event; do
    node="$(echo "$event" | awk '{print $NF}')"
    node_class=$(bspc query -T -n "$node" | jq -r .client.className)
    if [[ "$node_class" == "$class" ]]; then
      break
    fi
  done
}

start_monitor() {
  current=$(bspc query -D -d focused --names)
  bspc desktop -f $TOFWEOD_MONITOR_DESKTOP

  if not tmux has-session -t terminal-tag 2>/dev/null; then
    alacritty -t sideterminal --class sideterminal -e tmux new -A -s terminal-tag &
    wait_for_class "sideterminal"
  fi

  if not pgrep -x cava >/dev/null; then
    alacritty -o "font.size=1" -t cava --class cavautil -e \
      $HOME/.local/bin/cava -p $HOME/.config/cava/sidebar-config &
    wait_for_class "cavautil"
  fi

  if not pgrep -x btop >/dev/null; then
    alacritty -o "font.size=10" -t statusutil --class statusutil -e btop &
    wait_for_class "statusutil"
  fi

  sleep 1.5
  bspc desktop -f $current
}

pgrep -x xfce4-power-man >/dev/null || xfce4-power-manager &
pgrep -x xautolock >/dev/null || xautolock -time 30 -locker "lock" &
pgrep -x fcitx5 >/dev/null || fcitx5 &
pgrep -x dunst >/dev/null || dunst &
pgrep -x picom >/dev/null || picom --animations &
pgrep -x polybar >/dev/null || $HOME/.config/bspwm/polybar/launch.sh &
pgrep -x copyq >/dev/null || copyq &
pgrep -x birdtray >/dev/null || birdtray &
protonplus update all >/dev/null &

start_monitor
