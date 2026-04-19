#! /bin/bash

player=""
action=""

usage() {
  echo "music-mpris.sh -p player [-a previous/next/play-pause]"
}

metadata() {
  artist=$(playerctl -p $1 metadata | grep -E 'artist' | awk '{for(i=3;i<NF;i++){printf "%s ",$i};printf "%s",$i}')
  title=$(playerctl -p $1 metadata | grep -E 'title' | awk '{for(i=3;i<NF;i++){printf "%s ",$i};printf "%s",$i}')
  echo "$title"-"$artist"
}

while getopts "p:a:" opt; do
  case $opt in
  p) player="$OPTARG" ;;
  a) action="$OPTARG" ;;
  *) usage ;;
  esac
done

if [[ -z $player ]]; then
  usage
  exit 1
fi

if [[ -z $action ]]; then
  metadata $player
else
  playerctl -p $player $action
fi
