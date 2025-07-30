{
  lib,
  stdenv,
  ncurses,
  zlib,
  fetchFromGitHub,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "arim";
  version = "2.12";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "arim";
    tag = "${finalAttrs.version}";
    hash = "sha256-Lcp8xrFO+VvvIh+STcGXbLU3zdhGuo6Ert9MwK5KRrM=";
  };

  buildInputs = [
    ncurses
    zlib
  ];

  env.NIX_CFLAGS_COMPILE = "-Wno-format-security";

  meta = {
    description = "Amateur Radio Instant Messaging";
    homepage = "https://github.com/radiocatalog/arim";
    changelog = "https://github.com/radiocatalog/arim/blob/${finalAttrs.src.tag}/NEWS";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      pkharvey
      matthewcroughan
      sarcasticadmin
    ];
    mainProgram = "arim";
    platforms = lib.platforms.all;
  };
})
