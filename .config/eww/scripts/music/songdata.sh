#!/bin/sh

capitalize () {
  toshow="$1"
  maxlen="$2"

  sufix=""

  if test $(echo $toshow | wc -c) -ge $maxlen ; then
    sufix=" ..."
  fi

  echo "${toshow:0:$maxlen}$sufix"
}

withSafe () {
  local txt="$1"
  local safe="$2"
  if [[ $txt == "" ]]; then
    echo $safe
  else
    echo $txt
  fi
}

if [[ $1 == "title" ]]; then
  capitalize "$(playerctl metadata --format "{{title}}" || echo "Not playing")" 45
fi

if [[ $1 == "artist" ]]; then
  withSafe "$(capitalize "$(playerctl metadata --format "{{artist}}" || echo "No artist")" 50)" "No artist detected"
fi

if [[ $1 == "album" ]]; then
  withSafe "$(capitalize "$(playerctl metadata --format "{{album}}" || echo "No artist")" 50)" "No album detected"
fi

if [[ $1 == "status" ]]; then
  playerctl status || echo 'Paused'
fi
