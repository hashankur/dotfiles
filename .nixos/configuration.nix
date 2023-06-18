# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }@args: {

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than-7d";
    };
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" "amd_pstate=active" ];
    # kernelModules = [ "amd-pstate" ];
    supportedFilesystems = [ "btrfs" "ntfs" ];
    # extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];
  };

  networking.hostName = "odyssey"; # Define your hostname.
  networking.wireless.enable =
    false; # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Bluetooth battery
  hardware.bluetooth = {
    enable = true;
    settings = { General = { Experimental = true; }; };
  };

  # Set your time zone.
  time = {
    timeZone = "Asia/Colombo";
    hardwareClockInLocalTime = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
  };
  environment.gnome.excludePackages = (with pkgs; [ gnome-tour ]);

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.han = {
      isNormalUser = true;
      description = "Hashan";
      extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
      shell = pkgs.fish;
    };
  };

  # Fonts
  fonts = {
    fonts = with pkgs; [ iosevka-bin ibm-plex ];

    # fontconfig.defaultFonts = {
    #   serif = [ "IBM Plex Serif" "Noto Serif" "Noto Color Emoji" ];
    #   sansSerif = [ "IBM Plex Sans" "Noto Sans" "Noto Color Emoji" ];
    #   monospace = [ "Iosevka" "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
    #   emoji = [ "Noto Color Emoji" ];
    # };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox-devedition-bin
    obsidian
    tdesktop
    transmission-gtk
    zotero

    ## Games
    gamemode
    bottles
    mangohud
    gamescope

    ## Media
    tauon
    gimp
    inkscape
    foliate
    mpv
    # pitivi
    # handbrake

    ## Office
    libreoffice-fresh
    zathura
    typst

    ## Programming
    # vscode
    nodejs
    # yarn
    # rustup
    # rust-analyzer
    # python3Full
    # (python3.withPackages (ps:
    #   with ps; [
    #     pip
    #     black
    #     flake8
    #     ipython
    #     mypy
    #     pylint
    #     pytest
    #     yapf
    #     python-lsp-server
    #     pillow
    #   ]))
    # contrast
    # gaphor
    # gcc
    # flutter
    # scrcpy
    nixfmt

    ## Terminal
    # alacritty
    starship
    exa
    tealdeer
    btop
    neofetch
    ranger
    kitty
    helix # Do not forget to add an editor to edit configuration.nix!
    neovim
    wget
    killall
    unrar
    yadm

    ## Other
    ripgrep
    fd
    gnome.gnome-tweaks
    pavucontrol
    capitaine-cursors
    cloudflare-warp
    distrobox
    gradience
    adw-gtk3

    # swaylock
    swayidle
    wlsunset
    mako # notification system developed by swaywm maintainer
    rofi-wayland
    wob
    swayosd
    playerctl
    libnotify
    pamixer
    hyprpaper
    waybar
    hyprpicker

    # Screenshot
    grim
    sway-contrib.grimshot
    slurp

    # Clipboard
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    clipman
    bemenu # wayland clone of dmenu

    eww-wayland
    encfs
    sshfs
    jq
    socat
  ];

  # Enable sway window manager
  programs = {
    hyprland = {
      enable = true;
    };

    git = {
      enable = true;
      config = { init = { defaultBranch = "main"; }; };
    };

    light.enable = true;
    kdeconnect.enable = false;
    fish.enable = true;
  };

  # ZRAM
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services = {
    # SSD TRIM
    fstrim.enable = true;
    btrfs.autoScrub.enable = true;

    # Power savings
    power-profiles-daemon.enable = false;
    auto-cpufreq.enable = true;

    # Syncthing
    syncthing = {
      enable = false;
      user = "han";
      configDir = "/home/han/.config/syncthing";
      overrideFolders = false;
      guiAddress = "127.0.0.1:5050";
      openDefaultPorts = true;
    };

  };

  virtualisation.docker.enable = true;

  #virtualisation.waydroid.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8081 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
