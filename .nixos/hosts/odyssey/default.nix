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
      extraGroups = [ "networkmanager" "wheel" "video" "docker" "adbusers" ];
      shell = pkgs.fish;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox-devedition-bin
    obsidian
    transmission-gtk
    # zotero
    thunderbird-bin

    ## Media
    # pitivi
    handbrake
    kooha
    youtube-dl
    tartube
    obs-studio
    xournalpp
    drawio

    ## Office
    zathura
    typst
    staruml

    distrobox
  ];

  # List services that you want to enable:
  services = {
    # Syncthing
    syncthing = {
      enable = false;
      user = "han";
      configDir = "/home/han/.config/syncthing";
      overrideFolders = false;
      guiAddress = "127.0.0.1:5050";
      openDefaultPorts = true;
    };

    # cloudflare-warp = {
      # enable = true;
      # certificate = ./modules/Cloudflare_CA.pem; # download here https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/install-cloudflare-cert/
    # };
  };

  virtualisation.docker.enable = true;

  #virtualisation.waydroid.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
