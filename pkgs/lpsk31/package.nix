{
  lib,
  stdenv,
  ncurses,
  alsa-lib,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "lpsk31";
  version = "1.4";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "lpsk31";
    rev = version;
    hash = "sha256-WZ2EvyZHx1QvVA4CIVG6CU5ke/8yImvxkFLOJLLxNa4=";
  };

  preInstall = ''
    mkdir -p $out/bin
    mkdir -p $out/share/doc
    export HOME=$TMPDIR
  '';

  makeFlags = [
    "BINDIR=$(out)/bin"
    "DOCDIR=$(out)/share/doc"
  ];

  buildInputs = [
    ncurses
    alsa-lib
  ];

  meta = {
    description = "Ncurses-based Linux console application for PSK31 digital mode";
    homepage = "https://github.com/radiocatalog/lpsk31.git";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      matthewcroughan
      sarcasticadmin
      pkharvey
    ];
    mainProgram = "lpsk31";
    platforms = lib.platforms.all;
  };
}
