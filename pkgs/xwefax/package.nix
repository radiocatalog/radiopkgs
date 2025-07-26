{
  lib,
  pkg-config,
  gtk3,
  alsa-lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "xwefax";
  version = "2.4.4";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "xwefax";
    rev = "899f46dd05018e675f7b30f0d8e3c50486a39564";
    hash = "sha256-AydmCg4EHGONa4LVPunPANM9Sf9olOZvj1oQIO3ZOKM=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gtk3 alsa-lib ];


  meta = {
    description = "Decoding, display and saving of Wefax/Radiofax images";
    homepage = "https://github.com/radiocatalog/xwefax";
    changelog = "https://github.com/radiocatalog/xwefax/blob/${src.rev}/ChangeLog";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      pkharvey
      matthewcroughan
      sarcasticadmin
    ];
    mainProgram = "xwefax";
    platforms = lib.platforms.all;
  };
}
