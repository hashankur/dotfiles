{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    tdesktop

    ## Media
    tauon
    gimp
    inkscape
    # foliate
    mpv

    ## Office
    libreoffice-fresh

    tealdeer
    btop
    neofetch
    wget
    killall
    unrar
    libnotify

    gnome.gnome-tweaks
    pavucontrol
    adw-gtk3
  ];

  fonts = {
    packages = with pkgs; [
      iosevka-bin
      noto-fonts
      noto-fonts-cjk
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

  programs = { fish.enable = true; };

  services = {
    # Power savings
    auto-cpufreq.enable = true;
  };

  # ZRAM
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };
}
