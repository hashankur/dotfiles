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
      substituters = [
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      trusted-users = [
        "root"
        "han"
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
