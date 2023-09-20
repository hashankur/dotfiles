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
      # Slows down write operations considerably?
      auto-optimise-store = false;
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
      };
      efi = { canTouchEfiVariables = true; };
    };
    kernelPackages = pkgs.linuxPackages_zen;
    supportedFilesystems = [ "btrfs" "ntfs" ];
  };

  networking = {
    hostName = "perseus"; # Define your hostname.
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
  time = { timeZone = "Asia/Colombo"; };

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
    users = {
      merina = {
        isNormalUser = true;
        description = "Maraine Kelsey";
        extraGroups = [ "networkmanager" "wheel" "video" ];
        shell = pkgs.fish;
      };
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqBF4ubUR5n+a9YTCIZroTPcmk48AtS6rfDkeZmBptL han@odyssey"
        ];
      };
    };
  };

  fonts = {
    packages = with pkgs; [ noto-fonts noto-fonts-cjk noto-fonts-emoji ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
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
    helix # Do not forget to add an editor to edit configuration.nix!
    wget
    killall
    unrar

    gnome.gnome-tweaks
    pavucontrol
    capitaine-cursors
    gradience
    adw-gtk3
  ];

  programs = {
    kdeconnect.enable = true;
    fish.enable = true;
  };

  # ZRAM
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  # List services that you want to enable:
  services = {
    auto-cpufreq.enable = true;
    # Enable the OpenSSH daemon.
    openssh.enable = true;
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
