{ niri, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # hyprlock
    hypridle
    # hyprpicker
    # wlsunset
    gammastep
    # wluma
    # rofi-wayland
    playerctl
    libnotify
    # pamixer
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

    encfs
    gocryptfs
    zenity
    sshfs
    jq
    socat
    bc
    ripgrep
    fd
    xwayland-satellite
  ];

  nixpkgs.overlays = [ niri.overlays.niri ];

  # stylix.image = "../../assets/wallhaven-kxvqp7.jpg";

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  fonts = {
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; }) ];
  };

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    xwayland = {
      enable = true;
    };
  };

  services = {
    # High CPU usage for extended periods of time
    # gnome.tracker.enable = false;
    # gnome.tracker-miners.enable = false;

    power-profiles-daemon.enable = false;

    # Power savings
    auto-cpufreq.enable = true;
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
