{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gamemode
    bottles
    mangohud
    gamescope
    # gnome.aisleriot
    # gnome.gnome-chess
    # ryujinx
    # lutris
    # umu.packages.${pkgs.system}.umu
    # wineWowPackages.stagingFull
  ];

  hardware.graphics = {
    ## radv: an open-source Vulkan driver from freedesktop
    enable32Bit = true;

    ## amdvlk: an open-source Vulkan driver from AMD
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };
}
