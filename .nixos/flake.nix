{
  # Description, write anything or even nothing
  description = "Han's NixOS Flake";

  # Input config, or package repos
  inputs = {
    # Nixpkgs, NixOS's official repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  # Output config, or config for NixOS system
  outputs = { self, nixpkgs, home-manager, chaotic, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      lib = nixpkgs.lib;
      conf = self.nixosConfigurations;

    in {
      nixosConfigurations = {
        odyssey = lib.nixosSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            ./hosts/odyssey
            ./modules/core.nix
            ./modules/desktop.nix
            ./modules/dev.nix
            ./modules/gaming.nix
            ./modules/hyprland.nix
            ./modules/nix.nix
            ./modules/ssd.nix
            ./modules/terminal.nix
            chaotic.nixosModules.default

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.han = import ./home-manager/home.nix;
            }
          ];
        };
      };


      # Add this output, colmena will read its contents for remote deployment
      colmena = {
        meta = {
          nixpkgs = pkgs;
          nodeNixpkgs = builtins.mapAttrs (name: value: value.pkgs) conf;
          nodeSpecialArgs = builtins.mapAttrs (name: value: value._module.specialArgs) conf;

          # This parameter functions similarly to `sepcialArgs` in `nixosConfigurations.xxx`,
          # used for passing custom arguments to all submodules.
          specialArgs = { inherit nixpkgs; };
        };

        "perseus" = { name, nodes, ... }: {
          # Parameters related to remote deployment
          deployment.targetHost = "perseus.local"; # Remote host's IP address
          deployment.targetUser = "root"; # Remote host's username
          deployment.buildOnTarget = false;

          # This parameter functions similarly to `modules` in `nixosConfigurations.xxx`,
          # used for importing all submodules.
          imports = [
            ./hosts/perseus
            ./modules/core.nix
            ./modules/desktop.nix
            ./modules/nix.nix
          ];
        };
      };
    };
}
