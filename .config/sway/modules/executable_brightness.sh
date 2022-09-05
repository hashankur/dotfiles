#!/usr/bin/env bash

# Author: https://github.com/x0rzavi
# Description: Brightness manipulation
# Dependencies: acpilight

inc_brightness () {
	brightnessctl set +5%
}

dec_brightness () {
	brightnessctl set 5-%
}

show_help () {
	cat <<EOF
Usage: brightness.sh [options]

AVAILABLE OPTIONS:
  --get         get current brightness
  --inc         increase current brightness by +4
  --dec         decrease current brightness by -4
EOF
}

if [[ "$1" == "--get" ]]; then
	get_brightness
elif [[ "$1" == "--inc" ]]; then
	inc_brightness
elif [[ "$1" == "--dec" ]]; then
	dec_brightness
else
	show_help
fi
