{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vscode
    nodejs
    yarn
    bun
    rustup
    rust-analyzer
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
    #   ]))
    # contrast
    # gaphor
    # gcc
    lldb
    # flutter
    # scrcpy
    jetbrains.idea-community

    nixfmt
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    marksman
    nil
    rust-analyzer
    nodePackages_latest.svelte-language-server
    nodePackages_latest."@tailwindcss/language-server"
    nodePackages_latest.prisma
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
  };

  services = {
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };
}
