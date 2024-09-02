{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tdesktop

    ## Media
    # tauon
    gimp
    inkscape
    # foliate
    mpv

    ## Office
    libreoffice-fresh

    tealdeer
    btop
    neofetch
    wget2
    killall
    unrar
    libnotify

    gnome-tweaks
    adw-gtk3
    nh
  ];

  fonts = {
    packages = with pkgs; [
      iosevka-bin
      inter
      # noto-fonts-color-emoji
      # twitter-color-emoji
    ];

    # fontconfig.defaultFonts = {
    #   serif = [ "Noto Serif" ];
    #   sansSerif = [ "Twitter Color Emoji" "Noto Sans" "Noto Sans Sinhala" "Symbols Nerd Font"];
    #   # monospace = [ "Iosevka" ];
    #   emoji = [ "Twitter Color Emoji" ];
    # };
  };

  programs = {
    fish.enable = true;
  };

  # ZRAM
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };
}
