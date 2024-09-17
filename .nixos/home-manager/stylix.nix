{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/kx/wallhaven-kxvqp7.jpg";
      sha256 = "sha256-0p49GSybwWbaxK/AbLMtUXLdvg5KhiIJ/G2Mubhd5tA=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
  };
}
