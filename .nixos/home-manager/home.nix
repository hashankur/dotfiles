{ inputs, pkgs, ... }: {
  home.stateVersion = "24.05";

  # add the home manager module
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = null;

    # packages to add to gjs's runtime
    extraPackages = [ pkgs.libsoup_3 ];
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.capitaine-cursors;
    name = "Capitaine Cursors";
    size = 8;
  };

  # gtk = {
    # enable = true;
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
