#!/bin/sh

colors="#c0caf5"
dimmed="#c0caf5"
empty="#414868"

focusedws=1

declare -A o=([1]=0 [2]=0 [3]=0 [4]=0 [5]=0 [6]=0 [7]=0 [8]=0 [9]=0 [10]=0)
declare -A monitormap
declare -A workspaces

# set -euxo pipefail

# sets color
status() {
  if [[ ${o[$1]} -eq 1 ]]; then
    mon=${monitormap[${workspaces[$1]}]}

    if [[ $focusedws -eq $1 ]]; then
      echo -n "color: ${colors[$mon]};"
    else
      echo -n "color: ${dimmed[$mon]};"
    fi
  else
    echo -n "color: $empty;"
  fi
}

getIcon() {
  if [[ ${o[$1]} -eq 1 ]]; then
    if [[ $focusedws -eq $1 ]]; then
      echo -n "" # focused icon
    else
      echo -n "" # occupied icon
    fi
  else
    echo -n "" # empty icon
  fi
}

# handles workspace create/destroy
workspace_event() {
  o[$1]=$2
  while read -r k v; do workspaces[$k]="$v"; done < <(hyprctl -j workspaces | jq -r '.[]|"\(.id) \(.monitor)"')
}
# handles monitor (dis)connects
monitor_event() {
  while read -r k v; do monitormap["$k"]=$v; done < <(hyprctl -j monitors | jq -r '.[]|"\(.name) \(.id) "')
}

# generates the eww widget
generate() {
  echo -n '(eventbox :onscroll "echo {} | sed -e \"s/up/-1/g\" -e \"s/down/+1/g\" | xargs hyprctl dispatch workspace" (box :orientation "h" :class "works" :spacing "15" :space-evenly "false" '
  for i in {1..10}; do
    echo -n "(button :onclick \"hyprctl dispatch workspace $i\" :class \"ws\" :style \"$(status "$i")\"  \"$(getIcon $i)\") "
  done
  echo '))'
}

# setup
# add monitors
monitor_event
# add workspaces
workspace_event 1 1
# check occupied workspaces
for num in "${!workspaces[@]}"; do
  o[$num]=1
done
# generate initial widget
generate

# main loop
socat -u UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r line; do
  case ${line%>>*} in
    "workspace")
      focusedws=${line#*>>}
      ;;
    "activemon")
      focusedws=${line#*,}
      ;;
    "createworkspace")
      workspace_event "${line#*>>}" 1
      ;;
    "destroyworkspace")
      workspace_event "${line#*>>}" 0
      ;;
    "monitor"*)
      monitor_event
      ;;
  esac
  generate
done
