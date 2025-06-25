#! /bin/bash

artist=$(playerctl -p yesplaymusic metadata | grep -E 'artist' | awk '{for(i=3;i<NF;i++){printf "%s ",$i};printf "%s",$i}')
title=$(playerctl -p yesplaymusic metadata | grep -E 'title' | awk '{for(i=3;i<NF;i++){printf "%s ",$i};printf "%s",$i}')

echo "$title"-"$artist"
