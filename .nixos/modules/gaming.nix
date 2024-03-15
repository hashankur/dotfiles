{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gamemode
    bottles
    mangohud
    gamescope
    gnome.aisleriot
    gnome.gnome-chess
    ryujinx
  ];
}
