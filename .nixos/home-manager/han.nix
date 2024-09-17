{ inputs, pkgs, ... }:
{
  home.stateVersion = "24.05";

  # add the home manager module
  imports = [
    ./ags.nix
    ./spicetify.nix
    # ./stylix.nix # see wm.nix

    inputs.ala-lape.homeManagerModules.default
  ];

  services.ala-lape = {
    enable = false;
    package = inputs.ala-lape;
    config = {
      limits = {
        poll_frequency = "300s";
        activity_timeout = "300s";
      };
      process = [ { name = "qemu-system-x86_64"; } ];
    };
  };
}
