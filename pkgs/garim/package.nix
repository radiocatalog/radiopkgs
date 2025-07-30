{
  lib,
  stdenv,
  fetchFromGitHub,
  fltk,
  zlib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "garim";
  version = "1.7";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "garim";
    rev = finalAttrs.version;
    hash = "sha256-SzRUqvP49jLiDL7cCJM3TVcCG+VTSticYgk1/iDC+VU=";
  };

  nativeBuildInputs = [
    fltk
    zlib
  ];

  meta = {
    description = "GUI host mode program for the ARDOP TNC";
    homepage = "https://github.com/radiocatalog/garim";
    changelog = "https://github.com/radiocatalog/garim/blob/${finalAttrs.src.rev}/NEWS";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      pkharvey
      matthewcroughan
      sarcasticadmin
    ];
    mainProgram = "garim";
    platforms = lib.platforms.unix;
  };
})
