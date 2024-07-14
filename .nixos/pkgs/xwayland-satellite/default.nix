{
  lib,
  fetchFromGitHub,
  rustPlatform,
  xcb-util-cursor,
  pkg-config,
  xwayland,
  makeWrapper,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "xwayland-satellite";
  version = "0.4";

  src = fetchFromGitHub {
    owner = "Supreeeme";
    repo = "xwayland-satellite";
    rev = "v${version}";
    sha256 = "sha256-dwF9nI54a6Fo9XU5s4qmvMXSgCid3YQVGxch00qEMvI=";
  };

  nativeBuildInputs = [
    rustPlatform.bindgenHook # Find libclang.so
    pkg-config
  ];

  buildInputs = [
    xcb-util-cursor
    makeWrapper
  ];

  postInstall = ''
    wrapProgram $out/bin/xwayland-satellite \
      --prefix PATH : "${lib.makeBinPath [ xwayland ]}"
  '';

  # Tests are failing in Nix builds
  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  meta = {
    mainProgram = pname;
    description = "Xwayland outside your wayland";
    homepage = "https://github.com/${src.owner}/${src.repo}";
    license = lib.licenses.mspl;
    maintainers = [ ];
  };
}
