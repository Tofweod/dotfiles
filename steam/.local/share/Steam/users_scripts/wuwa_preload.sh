#!/usr/bin/env bash

FILEDIR="$HOME/wind/Wuthering Waves/Wuthering Waves Game/Client/Binaries/Win64/ThirdParty/KrPcSdk_Mainland/KRSDKRes"
FILENAME="$FILEDIR/KRSDKConfig.json"

BACKUP="$FILENAME.steam.bak"

change_to_steam_channelId() {
  if [[ ! -f "$BACKUP" ]]; then
    cp -a "$FILENAME" "$BACKUP"
  fi

  notify-send "Changed ChannelId into 205"
  tmp=$(mktemp)
  jq '.KR_ChannelId = "205"' "$FILENAME" >"$tmp" &&
    mv "$tmp" "$FILENAME"
}

restore_to_default_channelId() {
  if [[ -f "$BACKUP" ]]; then
    notify-send "Restore ChannelId"
    mv "$BACKUP" "$FILENAME"
  else
    notify-send "No backup of ChannelId"
  fi
}
