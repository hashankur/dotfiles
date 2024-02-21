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
    # ]))
    # contrast
    # gaphor
    gcc
    # flutter
    # scrcpy
    # jetbrains.idea-community
    # maven
    android-studio
    kotlin
    jdt-language-server

    nil
    nixfmt
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    nodePackages_latest.svelte-language-server
    nodePackages_latest."@tailwindcss/language-server"
    marksman
    lldb
    lua-language-server
    (callPackage ../pkgs/helix-gpt/package.nix { })
    taplo
    # black
    # python-lsp-ruff
    kotlin-language-server
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
