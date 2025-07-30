{
  lib,
  stdenv,
  fetchFromGitHub,
  fltk,
  zlib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "varim";
  version = "1.12";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "varim";
    rev = finalAttrs.version;
    hash = "sha256-vtTwsnvzdPZAAX2lZjUv9BOQusmfHYjzRzQc8Gge4I4=";
  };

  nativeBuildInputs = [
    fltk
    zlib
  ];

  meta = {
    description = "GUI host mode program for the VARA HF Modem";
    homepage = "https://github.com/radiocatalog/varim";
    changelog = "https://github.com/radiocatalog/varim/blob/${finalAttrs.src.rev}/ChangeLog";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      pkharvey
      matthewcroughan
      sarcasticadmin
    ];
    mainProgram = "varim";
    platforms = lib.platforms.unix;
  };
})
