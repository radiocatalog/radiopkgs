{
  lib,
  gcc9Stdenv,
  libxcrypt,
  fetchFromGitHub,
}:

gcc9Stdenv.mkDerivation rec {
  pname = "axmail";
  version = "2.13";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "axmail";
    rev = version;
    hash = "sha256-nZbJBglbgP/rBrFEKdV+yHVOhJ3qytgA5YtC8jfECzY=";
  };

  buildInputs = [ libxcrypt ];

  makeFlags = [
    "MAN_DIR=$(out)/share/man"
  ];

  prePatch = ''
    mkdir -p $out/share/man/{man5,man8}
    mkdir -p $out/bin
    substituteInPlace Makefile --replace-fail '/usr/local/sbin' "$out/bin"
    substituteInPlace Makefile --replace-fail '/usr/local/etc' "$out/etc"
    substituteInPlace Makefile --replace-fail 'install: installbin installconf installhelp installman' 'install: installbin installconf installman'
    substituteInPlace Makefile --replace-fail '-o root -g root' ""
    cat Makefile
  '';

  meta = {
    description = "SMTP mailbox for linux based packet node servers";
    homepage = "https://github.com/radiocatalog/axmail";
    license = with lib.licenses; [
      gpl2Plus
    ];
    maintainers = with lib.maintainers; [
      matthewcroughan
      sarcasticadmin
      pkharvey
    ];
    mainProgram = "axmail";
    platforms = lib.platforms.linux;
  };
}
