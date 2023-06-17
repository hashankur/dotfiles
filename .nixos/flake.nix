{
  # Description, write anything or even nothing
  description = "Han's NixOS Flake";

  # Input config, or package repos
  inputs = {
    # Nixpkgs, NixOS's official repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  # Output config, or config for NixOS system
  outputs = { self, nixpkgs }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib; # Is it really necessary?
    in {
      # Define a system called "nixos"
      nixosConfigurations."odyssey" = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };

      # You can define many systems in one Flake file.
      # NixOS will choose one based on your hostname.
      #
      # nixosConfigurations."nixos2" = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     ./configuration2.nix
      #   ];
      # };
    };
}
