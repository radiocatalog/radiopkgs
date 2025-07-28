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

  # will repoint to radiocatalog after repo is pushed
  src = fetchFromGitHub {
    owner = "nwdigitalradio";
    repo = "rmsgw";
    rev = "029f23fccffd05c19447896a36d926b28366d344";
    sha256 = "sha256-cwNUoLFPnXO2uqj7dJz1ccCVgPZhtHLC1iPKEv12NZI=";
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
    license = licenses.gpl2;
    maintainers = with lib.maintainers; [
      matthewcroughan
      sarcasticadmin
      pkharvey
    ];
    platforms = platforms.linux;
  };
}
