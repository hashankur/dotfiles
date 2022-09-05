#!/usr/bin/env bash

# Safer script
trap "exit" INT
set -euo pipefail

# Author: https://github.com/x0rzavi
# Description: Install my favourite fonts
# Dependencies: aria2, 7z

# Variables
directory=$(pwd)

rm -fr $directory/tmpdir
mkdir -p $directory/tmpdir
cd $directory/tmpdir

apple_fonts () {
	aria2c -x16 "https://github.com/x0rzavi/apple-fonts-nerd-patched/releases/download/v1/AppleFontsNerdPatched.7z"
	7z x "AppleFontsNerdPatched.7z" -o$directory/tmpdir
	rm -rf AppleFontsNerdPatched.7z
}

jetbrainsmono () {
	mkdir -p $directory/tmpdir/JetBrainsMono
	
	curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
	| grep "browser_download_url.*JetBrainsMono.zip" | cut -d : -f 2,3 \
	| xargs aria2c -x16
	7z x "JetBrainsMono.zip" -o$directory/tmpdir/JetBrainsMono
	rm -rf JetBrainsMono.zip
	
}

iosevka () {
	mkdir -p $directory/tmpdir/Iosevka
	
	curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
	| grep "browser_download_url.*Iosevka.zip" | cut -d : -f 2,3 \
	| xargs aria2c -x16
	7z x "Iosevka.zip" -o$directory/tmpdir/Iosevka
	rm -rf Iosevka.zip
	
}

install_fonts () {
	apple_fonts
	jetbrainsmono
	iosevka
	echo -e "\n\n\nPlease input your root password to proceed for moving files:\n"
	sudo mkdir -p /usr/local/share/fonts/
	sudo mv $directory/tmpdir/* /usr/local/share/fonts/
	fc-cache --really-force --verbose
	rm -rf $directory/tmpdir
}

install_fonts
