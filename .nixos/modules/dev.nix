{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vscode.fhs
    nodejs
    yarn
    python3Full
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
    #     jupyter
    # ]))
    # contrast
    # gaphor
    gcc
    # flutter
    # scrcpy
    # jetbrains.idea-community
    # maven

    nixfmt
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    marksman
    nil
    nodePackages_latest.svelte-language-server
    nodePackages_latest."@tailwindcss/language-server"
    nodePackages_latest.prisma
    lldb
    lua-language-server
  ];

  programs = {
    git = {
      enable = true;
      config = { init = { defaultBranch = "main"; }; };
    };

    adb.enable = true;

    java = {
      enable = true;
      package = pkgs.temurin-bin;
    };

    direnv.enable = true;
  };

  services = {
    mysql = {
      enable = false;
      package = pkgs.mariadb;
    };
  };
}
