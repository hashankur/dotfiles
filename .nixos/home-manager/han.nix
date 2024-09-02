{ inputs, pkgs, ... }:
{
  home.stateVersion = "24.05";

  # add the home manager module
  imports = [
    ./ags.nix
    ./spicetify.nix
    # ./stylix.nix
  ];
}
