{
  lib,
  stdenv,
  ncurses,
  zlib,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "arim";
  version = "unstable-2025-07-19";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "arim";
    rev = "a6b3892a1092024052d5af0d895af4dbe5e0b625";
    hash = "sha256-Lcp8xrFO+VvvIh+STcGXbLU3zdhGuo6Ert9MwK5KRrM=";
  };

  buildInputs = [ ncurses zlib ];

  env.NIX_CFLAGS_COMPILE = "-Wno-format-security";

  meta = {
    description = "Amateur Radio Instant Messaging";
    homepage = "https://github.com/radiocatalog/arim";
    changelog = "https://github.com/radiocatalog/arim/blob/${src.rev}/NEWS";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      pkharvey
      matthewcroughan
      sarcasticadmin
    ];
    mainProgram = "arim";
    platforms = lib.platforms.all;
  };
}
