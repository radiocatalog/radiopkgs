{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "dpbox";
  version = "6.00.00";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "dpbox";
    rev = version;
    hash = "sha256-F/AVQVoUW0srbdelfR1cMxdjbFMTiFDV3sDt3HL+FQQ=";
  };

  sourceRoot = "source/source";

  env.NIX_CFLAGS_COMPILE = "-Wno-format-security";

  patchPhase = ''
    runHook prePatch
    sed -i '/#include "box_sub.h"/a #include <time.h>' filesys.c
    sed -i '/#include "shell.h"/a #include <time.h>' box_sub.c
    sed -i '/#include "box_wp.h"/a #include <time.h>' box_tim.c
    sed -i '/#include <unistd.h>/a #include <time.h>' pastrix.c
    sed -i '/#include "main.h"/a #include <time.h>' init.c
    sed -i '/#include "box_wp.h"/a #include <time.h>' main.c
    sed -i '/#include "box_wp.h"/a #include <time.h>' box_garb.c
    sed -i '/#include "md2md5.h"/a #include <string.h>' md2md5.c
    sed -i 's/static boolean may_invoke_xeditor(unr)/static boolean may_invoke_xeditor(int unr)/' box.c
    sed -i 's/short calc_usernr(console,channel)/short calc_usernr(int console, int channel)/' main.c
    runHook postPatch
  '';

  buildPhase = ''
    runHook preBuild
    make clean
    make dep
    make all
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp dpbox $out/bin/
    runHook postInstall
  '';

  meta = {
    description = "Multi protocol and multi user BBS";
    homepage = "https://github.com/radiocatalog/dpbox";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [
      pkharvey
      matthewcroughan
      sarcasticadmin
    ];
    mainProgram = "dpbox";
    platforms = lib.platforms.all;
  };
}
