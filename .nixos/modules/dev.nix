{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vscode.fhs
    zed-editor_git
    nodejs
    yarn
    bun
    python3Full
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
    # jetbrains.idea-community
    # android-studio
    # jdt-language-server
    jetbrains-toolbox
    # volta

    nil
    nixfmt-rfc-style
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    nodePackages_latest."@tailwindcss/language-server"
    marksman
    # lldb
    lua-language-server
    helix-gpt
    taplo
    # black
    ruff-lsp
    pyright
    # nodePackages_latest.vls
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

    java = {
      enable = false;
      package = pkgs.temurin-bin;
    };

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
