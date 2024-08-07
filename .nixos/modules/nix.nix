{ nixpkgs, ... }:
{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than-1w";
    };
    registry.nixpkgs.flake = nixpkgs; # Reuse system nixpkgs for flakes
    settings = {
      # Slows down write operations considerably?
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      builders-use-substitutes = true;
      substituters = [ ];

      trusted-public-keys = [ ];

      trusted-users = [
        "root"
        "han"
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
