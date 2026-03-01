#! /bin/bash

artist=$(playerctl -p $1 metadata | grep -E 'artist' | awk '{for(i=3;i<NF;i++){printf "%s ",$i};printf "%s",$i}')
title=$(playerctl -p $1 metadata | grep -E 'title' | awk '{for(i=3;i<NF;i++){printf "%s ",$i};printf "%s",$i}')

echo "$title"-"$artist"
