{ pkgs, ... }: {

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "odyssey"; # Define your hostname.
    # Enables wireless support via wpa_supplicant.
    wireless.enable = false;
    # Enable networking
    networkmanager.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.han = {
      isNormalUser = true;
      description = "Hashan";
      extraGroups =
        [ "networkmanager" "wheel" "video" "docker" "adbusers" "vboxusers" ];
      shell = pkgs.fish;
    };
  };

  nixpkgs.config.permittedInsecurePackages =
    [ "electron-25.9.0" "freeimage-unstable-2021-11-01" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox-devedition
    obsidian
    transmission-gtk
    # thunderbird-bin
    brave
    spotify

    ## Media
    pitivi
    handbrake
    kooha
    youtube-dl
    tartube
    obs-studio

    ## Office
    xournalpp
    zathura
    # typst
    staruml
    zotero

    distrobox
    megasync
    colmena
    mission-center

    # temp
    material-symbols
    anydesk
  ];

  # List services that you want to enable:
  services = {
    # Syncthing
    syncthing = {
      enable = true;
      user = "han";
      configDir = "/home/han/.config/syncthing";
      overrideFolders = false;
      guiAddress = "127.0.0.1:5050";
      openDefaultPorts = true;
    };

    tailscale.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;

  #virtualisation.waydroid.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
