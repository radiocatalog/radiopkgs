{
  lib,
  gcc13Stdenv,
  fetchFromGitHub,
  autoreconfHook,
  libxml2,
  ncurses5,
  pkg-config,
  libax25,
  python3,
}:

gcc13Stdenv.mkDerivation {
  pname = "rmsgw";
  version = "unstable-2024-12-28";

  src = fetchFromGitHub {
    owner = "radiocatalog";
    repo = "rmsgw";
    rev = "5ec9a3fced6400d1d200d0c7564531f43b6bfaff";
    sha256 = "sha256-7bShJ9z5Si2A6nWs+vP19l/tDOeIouWojBIbig/2nhU=";
  };

  buildInputs = [
    autoreconfHook
    ncurses5
    pkg-config
    libxml2
  ];

  propagatedBuildInputs =
    with python3.pkgs;
    [
      requests
    ]
    ++ [ libax25 ];

  configurePhase = ''
    ./configure --prefix=$out
  '';

  # Currently have to move things around since /etc/rmsgw is pretty messy
  postInstall = ''
    rm $out/etc/rmsgw/admin-update.sh

    mv $out/etc/rmsgw/rmsgwchantest $out/bin/
    mv $out/etc/rmsgw/*.py $out/bin/
    mv $out/etc/rmsgw/*.sh $out/bin/

    mkdir $out/share/config
    mv $out/etc/rmsgw/gateway.conf $out/share/config/
    mv $out/etc/rmsgw/banner $out/share/config/
    mv $out/etc/rmsgw/hosts $out/share/config/
    mv $out/etc/rmsgw/*.xml $out/share/config/
    mv $out/etc/rmsgw/channels.xsd $out/share/config/
  '';

  meta = with lib; {
    description = "Winlink RMS Gateway";
    license = [
      licenses.gpl2Plus
      licenses.gpl3Plus
    ];
    maintainers = with lib.maintainers; [
      matthewcroughan
      sarcasticadmin
      pkharvey
    ];
    platforms = platforms.linux;
  };
}
