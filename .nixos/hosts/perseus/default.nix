{ pkgs, ... }: {

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "perseus"; # Define your hostname.
    # Enables wireless support via wpa_supplicant.
    wireless.enable = false;
    # Enable networking
    networkmanager.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      merina = {
        isNormalUser = true;
        description = "Merina";
        extraGroups = [ "networkmanager" "wheel" "video" ];
        shell = pkgs.fish;
      };
      anne = {
        isNormalUser = true;
        description = "Anne K";
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
  environment.systemPackages = with pkgs; [ firefox ];

  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
