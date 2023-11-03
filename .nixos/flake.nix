{
  # Description, write anything or even nothing
  description = "Han's NixOS Flake";

  # Input config, or package repos
  inputs = {
    # Nixpkgs, NixOS's official repo
    nixpkgs.url =
      "github:NixOS/nixpkgs/nixos-unstable";

    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Output config, or config for NixOS system
  outputs = { self, nixpkgs, nix-gaming, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        odyssey = lib.nixosSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            ./hosts/odyssey
            ./modules/cloudflare-warp.nix
          ];
        };

        perseus = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/perseus ];
        };
      };

      # Add this output, colmena will read its contents for remote deployment
      colmena = {
        meta = {
          nixpkgs = pkgs;

          # This parameter functions similarly to `sepcialArgs` in `nixosConfigurations.xxx`,
          # used for passing custom arguments to all submodules.
          specialArgs = { inherit nixpkgs; };
        };

        "perseus" = { name, nodes, ... }: {
          # Parameters related to remote deployment
          deployment.targetHost = "perseus.local"; # Remote host's IP address
          deployment.targetUser = "root"; # Remote host's username
          deployment.buildOnTarget = true;

          # This parameter functions similarly to `modules` in `nixosConfigurations.xxx`,
          # used for importing all submodules.
          imports = [ ./hosts/perseus ];
        };
      };
    };
}
