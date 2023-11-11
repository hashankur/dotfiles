{pkgs, ...}:{
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
    capitaine-cursors
    gradience
    adw-gtk3
  ];
	
  fonts = {
    packages = with pkgs; [
      iosevka-bin
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];

    # fontconfig.defaultFonts = {
    #   serif = [ "IBM Plex Serif" "Noto Serif" "Noto Color Emoji" ];
    #   sansSerif = [ "IBM Plex Sans" "Noto Sans" "Noto Color Emoji" ];
    #   monospace = [ "Iosevka" "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
    #   emoji = [ "Noto Color Emoji" ];
    # };
  };

  programs = {
    kdeconnect.enable = true;
    fish.enable = true;
  };
  
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
