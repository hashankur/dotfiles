{
    nix = {
    settings = {
      # Slows down write operations considerably?
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];

      builders-use-substitutes = true;
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

}
