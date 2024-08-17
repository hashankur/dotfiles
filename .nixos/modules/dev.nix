{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vscode.fhs
    zed-editor
    nodejs
    bun
    # python3Full
    rustup
    # python3
    # (python3.withPackages (ps:
    #   with ps; [
    #     pip
    #     black
    #     flake8
    #     ipython
    #     mypy
    #     pylint
    #     pytest
    #     yapf
    #     python-lsp-server
    #     pillow
    # ]))
    # contrast
    # gaphor
    # gcc
    # flutter
    # scrcpy
    # jdt-language-server
    jetbrains-toolbox
    # volta

    nil
    nixfmt-rfc-style
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    nodePackages_latest."@tailwindcss/language-server"
    marksman
    lua-language-server
    helix-gpt
  ];

  programs = {
    git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "main";
        };
      };
    };

    adb.enable = true;

    # java = {
    #   enable = false;
    #   package = pkgs.temurin-bin;
    # };

    direnv.enable = false;

    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
      # libraries = with pkgs; [ stdenv.cc.cc.lib ];
    };
  };

  # services = {
  #   mysql = {
  #     enable = false;
  #     package = pkgs.mariadb;
  #   };
  # };
}
