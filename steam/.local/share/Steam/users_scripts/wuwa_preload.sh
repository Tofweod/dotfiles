#!/usr/bin/env bash

# Script Name: wuwa_preload.sh
# Description:
#   鸣潮相关游戏文件在linux和windows端共享
#   其中linux需要在steam上启动游戏
#   但此时会被远程视为国际版，KRSDKConfig.json里面的KR_ChannelId不匹配导致会强制下线
#   因此该脚本设置了两个函数用于设置对应KR_ChannelId以及恢复
# Author: Tofweod
# Usage: LAUNCH OPTIONS中`source ~/.local/share/Steam/users_scripts/wuwa_preload.sh ;
#   change_to_steam_channelId ;
#   trap restore_to_default_channelId EXIT TERM ; %command%`

FILEDIR="$HOME/wind"
FILENAME="$FILEDIR/Wuthering Waves/Wuthering Waves Game/Client/Binaries/Win64/ThirdParty/KrPcSdk_Mainland/KRSDKRes/KRSDKConfig.json"

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
