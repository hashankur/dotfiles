{ pkgs, nix-gaming, ... }: {
  environment.systemPackages = with pkgs; [
    gamemode
    bottles
    mangohud
    gamescope
    nix-gaming.packages.${pkgs.system}.wine-tkg
    gnome.aisleriot
    gnome.gnome-chess
  ];
}
