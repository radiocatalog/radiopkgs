{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "n0ary-bbs";
  version = "4.1.1";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "n0ary-bbs";
    rev = "9d847ba26453dda237e0853f97736438591fac7f";
    hash = "sha256-TgqTBFkdGwDbTRvgEY1JI2V3jcG33Z63oCb7QQ1T3AU=";
  };

  bbsDir = "/var/lib/n0ary-bbs";
  enableBbsTool = false;
  enableDectalk = false;
  enableDtmf = false;

  NIX_CFLAGS_COMPILE = "-Wno-error=unused-result";

  buildPhase = ''
    cat > src/include/site_config.mk <<EOF
BBS_DIR=${bbsDir}

FREEBSD=1
# SUNOS=0
# MACOSX=0
# OPENBSD=0

ENABLE_BBSTOOL=${if enableBbsTool then "1" else "0"}
ENABLE_DECTALK=${if enableDectalk then "1" else "0"}
ENABLE_DTMF=${if enableDtmf then "1" else "0"}
EOF

    cd src
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp bin/* $out/bin/
    mkdir -p $out/share/n0ary-bbs
    cp -r etc $out/share/n0ary-bbs/
  '';

  meta = {
    description = "A FreeBSD port of the venerable N0ARY packet radio BBS, which was originally written for SunOS";
    homepage = "https://github.com/radiocatalog/n0ary-bbs";
    changelog = "https://github.com/radiocatalog/n0ary-bbs/blob/${src.rev}/CHANGELOG";
    license = lib.licenses.bsdOriginal; # FIXME: no license mentioned in the README.md
    maintainers = with lib.maintainers; [
      pkharvey
      matthewcroughan
      sarcasticadmin
    ];
    mainProgram = "n0ary-bbs";
    platforms = lib.platforms.unix;
  };
}
