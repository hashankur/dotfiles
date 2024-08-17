{ inputs, pkgs, ... }:
{
  imports = [
    inputs.ags.homeManagerModules.default
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
}
