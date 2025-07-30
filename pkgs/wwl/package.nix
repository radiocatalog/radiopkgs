{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "wwl";
  version = "1.3";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "wwl";
    rev = version;
    hash = "sha256-kOW4znD6IobcHAaaIiebfqI662OQZoc07La52ckxo1s=";
  };

  preInstall = ''
    mkdir -p $out/bin
    mkdir -p $out/share/man/man1
  '';

  makeFlags = [
    "PREFIX=$(out)"
    "MANPREFIX=$(out)/share/man"
  ];

  meta = {
    description = "Calculates distance (qrb) and azimuth given two Maidenhead locators";
    homepage = "https://github.com/radiocatalog/wwl";
    license = lib.licenses.unfree; # No LICENSE
    maintainers = with lib.maintainers; [
      matthewcroughan
      pkharvey
      sarcasticadmin
    ];
    mainProgram = "wwl";
    platforms = lib.platforms.all;
  };
}
