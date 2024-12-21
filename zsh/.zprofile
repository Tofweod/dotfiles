if [ -f ~/.profile ]; then
    . ~/.profile
fi


if [ -n "$DISPLAY" ]; then
    dbus-update-activation-environment --systemd DISPLAY
fi
