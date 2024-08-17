{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  # import the flake's module for your system
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  # configure spicetify :)
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.spotifyNoPremium;
    # colorScheme = "mono";

    enabledCustomApps = with spicePkgs.apps; [ lyricsPlus ];

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      # keyboardShortcut
      powerBar
      songStats
      autoVolume
      betterGenres # genre
      adblock
      # beautifulLyrics
    ];
  };
}
