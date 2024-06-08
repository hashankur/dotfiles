{ inputs, pkgs, ... }:
let spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  # import the flake's module for your system
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  # configure spicetify :)
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.Comfy;
    colorScheme = "mono";

    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus
      marketplace
      localFiles
    ];

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      # keyboardShortcut
      powerBar
      songStats
      autoVolume
      # genre
      adblock
    ];
  };
}
