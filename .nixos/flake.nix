{
  # Description, write anything or even nothing
  description = "Han's NixOS Flake";

  # Input config, or package repos
  inputs = {
    # Nixpkgs, NixOS's official repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Output config, or config for NixOS system
  outputs = { self, nixpkgs, hyprland, hyprpicker, emacs-overlay }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        overlays = [
          hyprland.overlays.default
          hyprpicker.overlays.default
          (import self.inputs.emacs-overlay)
        ];
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
          hyprland.nixosModules.default
          {
            environment.systemPackages = with pkgs; [
              waybar-hyprland
              inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
              ((emacsPackagesFor emacsPgtk).emacsWithPackages
                (epkgs: [ epkgs.vterm epkgs.ccls ]))
            ];
          }
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
