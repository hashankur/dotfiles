{ hyprland, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # swaylock
    # gtklock
    swayidle
    # wlsunset
    gammastep
    # wluma
    rofi-wayland
    playerctl
    libnotify
    pamixer
    pulseaudio
    swww
    waybar
    brightnessctl

    # AGS
    typescript
    dart-sass
    bun

    # Screenshot
    grim
    sway-contrib.grimshot
    slurp

    # Clipboard
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    cliphist
    bemenu # wayland clone of dmenu

    # eww-wayland
    encfs
    gocryptfs
    gnome.zenity
    sshfs
    jq
    socat
    bc
    ripgrep
    fd
  ];

  # environment.sessionVariables = {
  #   # Hint electron apps to use wayland
  #   NIXOS_OZONE_WL = "1";
  # };

  fonts = {
    packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; }) ];
  };

  programs = {
    hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.system}.hyprland;
    };
  };

  services = {
    # High CPU usage for extended periods of time
    gnome.tracker.enable = false;
    gnome.tracker-miners.enable = false;

    power-profiles-daemon.enable = false;

    # clight.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
