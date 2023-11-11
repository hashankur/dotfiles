{ pkgs, nix-gaming, ... }: {

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      # Slows down write operations considerably?
      auto-optimise-store = true;

      builders-use-substitutes = true;
      # substituters to use
      substituters = [
        "https://nix-gaming.cachix.org"
      ];

      trusted-public-keys = [ 
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than-1w";
    };
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
      };
      efi = { canTouchEfiVariables = true; };
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # kernelParams = [ "amd_pstate=active" ];
    # kernelModules = [ "amd-pstate" ];
    supportedFilesystems = [ "btrfs" "ntfs" ];
    # extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];
  };

  networking = {
    hostName = "odyssey"; # Define your hostname.
    # Enables wireless support via wpa_supplicant.
    wireless.enable = false;
    # Enable networking
    networkmanager.enable = true;
  };

  # Bluetooth battery
  hardware.bluetooth = {
    enable = true;
    settings = { General = { Experimental = true; }; };
  };

  # Set your time zone.
  time = {
    timeZone = "Asia/Colombo";
    hardwareClockInLocalTime = false; # Fix: Messy system time jumps
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
      extraGroups = [ "networkmanager" "wheel" "video" "docker" "adbusers" ];
      shell = pkgs.fish;
    };
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      iosevka-bin
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];

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
    # zotero
    thunderbird-bin

    ## Games
    gamemode
    bottles
    mangohud
    gamescope
    nix-gaming.packages.${pkgs.system}.wine-tkg
    gnome.aisleriot
    gnome.gnome-chess

    ## Media
    tauon
    gimp
    inkscape
    mpv
    # pitivi
    handbrake
    kooha
    youtube-dl
    tartube
    obs-studio
    xournalpp
    drawio

    ## Office
    libreoffice-fresh
    zathura
    typst
    staruml

    ## Programming
    vscode
    nodejs
    yarn
    bun
    rustup
    rust-analyzer
    python3Full
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
    lldb
    # flutter
    # scrcpy
    jetbrains.idea-community

    nixfmt
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    marksman
    nil
    rust-analyzer
    nodePackages_latest.svelte-language-server
    nodePackages_latest."@tailwindcss/language-server"
    nodePackages_latest.prisma

    # lldb-vscode

    ## Terminal
    # alacritty
    starship
    eza
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
    # zellij
    gitui
    colmena

    ## Other
    ripgrep
    fd
    gnome.gnome-tweaks
    pavucontrol
    capitaine-cursors
    # cloudflare-warp
    distrobox
    gradience
    adw-gtk3

    # swaylock
    # gtklock
    swayidle
    # wlsunset
    gammastep
    wluma
    dunst
    rofi-wayland
    swayosd
    playerctl
    libnotify
    pamixer
    pulseaudio
    swww
    waybar
    hyprpicker
    networkmanagerapplet

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
    bc
  ];

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  programs = {
    hyprland = { enable = true; };

    git = {
      enable = true;
      config = { init = { defaultBranch = "main"; }; };
    };

    light.enable = true;
    fish.enable = true;
    adb.enable = true;
    java = { enable = true; package = pkgs.temurin-bin; };
    kdeconnect.enable = true;
  };

  # ZRAM
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

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

    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    # Enable the OpenSSH daemon.
    openssh.enable = false;

    # High CPU usage for extended periods of time
    gnome.tracker.enable = false;
    gnome.tracker-miners.enable = false;

    cloudflare-warp = {
      enable = true;
      # certificate = ./modules/Cloudflare_CA.pem; # download here https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/install-cloudflare-cert/
    };

    # clight.enable = true;
  };

  virtualisation.docker.enable = true;

  #virtualisation.waydroid.enable = true;

  fileSystems."/".options = [ "noatime" "compress=zstd" ];

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

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
