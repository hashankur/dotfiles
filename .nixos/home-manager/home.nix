{ inputs, pkgs, ... }:
{
  home.stateVersion = "24.05";

  # add the home manager module
  imports = [
    inputs.ags.homeManagerModules.default
    ./spicetify.nix
  ];

  programs.ags = {
    enable = true;
    # null or path, leave as null if you don't want hm to manage the config
    configDir = null;
    extraPackages = with pkgs; [
      libsoup_3
      gtksourceview
      gtksourceview4
      ollama
      python311Packages.material-color-utilities
      python311Packages.pywayland
      pywal
      dart-sass
      webkitgtk
      webp-pixbuf-loader
      # ydotool
    ];
  };

  home.packages = with pkgs; [
    ollama
    pywal
    dart-sass
    yad
    (python311.withPackages (p: [
      p.material-color-utilities
      p.pywayland
      p.setproctitle
    ]))
  ];

  # home.pointerCursor = {
  #   gtk.enable = true;
  #   x11.enable = true;
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Classic";
  #   size = 20;
  # };

  # gtk = {
  # enable = true;
  # cursorTheme = {
  #   package = pkgs.capitaine-cursors;
  #   name = "Capitaine-cursors";
  #   size = 8;
  # };
  # theme = {
  #   package = pkgs.adw-gtk3;
  #   name = "Adwaita GTK3";
  # };

  # iconTheme = {
  #   package = pkgs.gnome.adwaita-icon-theme;
  #   name = "Adwaita";
  # };

  # font = {
  #   name = "Sans";
  #   size = 11;
  # };
  # };
}
