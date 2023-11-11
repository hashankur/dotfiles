{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # alacritty
    starship
    eza
    ranger
    kitty
    helix
    yadm
    # zellij
    gitui
    colmena
  ];
}
