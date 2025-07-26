{
  lib,
  stdenv,
  pkg-config,
  gtk3,
  alsa-lib,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "xritty";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "xritty";
    rev = "61e6fb148f94b2f43dc86083457e3bd1a176d414";
    hash = "sha256-odNeDhLsgi1eUEDcmUrsryh6q+dG+o9OGIC9raI/+k4=";
  };

  buildInputs = [ gtk3 alsa-lib ];

  nativeBuildInputs = [ pkg-config ];

  env.NIX_CFLAGS_COMPILE = "-I${alsa-lib}/include";

  meta = {
    description = "GUI for communication in the RTTY (Radio Tele TYpe) mode";
    homepage = "https://github.com/radiocatalog/xritty";
    changelog = "https://github.com/radiocatalog/xritty/blob/${src.rev}/ChangeLog";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      pkharvey
      matthewcroughan
      sarcasticadmin
    ];
    mainProgram = "xritty";
    platforms = lib.platforms.all;
  };
}
