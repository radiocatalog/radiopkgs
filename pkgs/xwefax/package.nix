{
  lib,
  stdenv,
  fetchFromGitHub,
  alsa-lib,
  gtk3,
  pkg-config,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "xwefax";
  version = "2.4.4";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "xwefax";
    rev = finalAttrs.version;
    hash = "sha256-AydmCg4EHGONa4LVPunPANM9Sf9olOZvj1oQIO3ZOKM=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    gtk3
    alsa-lib
  ];

  meta = {
    description = "Decoding, display and saving of Wefax/Radiofax images";
    homepage = "https://github.com/radiocatalog/xwefax";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      matthewcroughan
      sarcasticadmin
      pkharvey
    ];
    mainProgram = "xwefax";
    platforms = lib.platforms.all;
  };
})
