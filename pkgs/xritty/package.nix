{
  lib,
  stdenv,
  pkg-config,
  gtk3,
  alsa-lib,
  fetchFromGitHub,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "xritty";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "xritty";
    tag = "${finalAttrs.version}";
    hash = "sha256-odNeDhLsgi1eUEDcmUrsryh6q+dG+o9OGIC9raI/+k4=";
  };

  buildInputs = [
    gtk3
    alsa-lib
  ];

  nativeBuildInputs = [ pkg-config ];

  env.NIX_CFLAGS_COMPILE = "-I${alsa-lib}/include";

  meta = {
    description = "GUI for communication in the RTTY (Radio Tele TYpe) mode";
    homepage = "https://github.com/radiocatalog/xritty";
    changelog = "https://github.com/radiocatalog/xritty/blob/${finalAttrs.src.tag}/ChangeLog";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      pkharvey
      matthewcroughan
      sarcasticadmin
    ];
    mainProgram = "xritty";
    platforms = lib.platforms.all;
  };
})
