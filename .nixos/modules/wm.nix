{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # hyprlock
    hypridle
    # hyprpicker
    # hyprshade
    # wlsunset
    gammastep
    # wluma
    # rofi-wayland
    playerctl
    libnotify
    # pamixer
    # pulseaudio
    swww
    waybar
    brightnessctl
    # dunst

    # Screenshot
    # grim
    # sway-contrib.grimshot
    # slurp

    # Clipboard
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    cliphist
    fzf
    bemenu # wayland clone of dmenu
    # clipse

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
    (callPackage ../pkgs/xwayland-satellite { })
    # xwayland-satellite
  ];

  # stylix.image = "../../assets/wallhaven-kxvqp7.jpg";

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  fonts = {
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; }) ];
  };

  programs = {
    hyprland = {
      enable = false;
    };

    niri = {
      enable = true;
    };

    auto-cpufreq.enable = true;
  };

  services = {
    # High CPU usage for extended periods of time
    # gnome.tracker.enable = false;
    # gnome.tracker-miners.enable = false;

    power-profiles-daemon.enable = false;

    # clight.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    user.services.niri-flake-polkit.enable = false;
  };
}
