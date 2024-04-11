{ pkgs, umu, ... }: {
  environment.systemPackages = with pkgs; [
    gamemode
    bottles
    mangohud
    gamescope
    gnome.aisleriot
    gnome.gnome-chess
    ryujinx
    # lutris
    umu.packages.${pkgs.system}.umu
  ];
}
