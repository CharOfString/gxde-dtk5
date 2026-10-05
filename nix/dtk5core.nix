# GXDE DTK5 Core

{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  qt5,
  dbus,
  gsettings-qt,
  icu,
  libuchardet,
  systemdLibs,
  dtk5common,
  dtklog,
  withSystemd ? stdenv.hostPlatform.isLinux,
}:

let
  inherit (import ./lib.nix { inherit lib; }) fixInstallPrefix;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "dtkcore";
  version = "6.7.43";

  src = fetchFromGitHub {
    owner = "GXDE-OS";
    repo = "dtk5core";
    rev = "16597fcd9c4afd2c26e4fe4d7a7f2edcb8a8b285"; # tag 6.7.43
    hash = "sha256-vIIvAbumwFPLE3NRaIfgo85NjXKyPSxqMR2CvAXPGPw=";
  };

  outputs = [ "out" "dev" ];

  dontWrapQtApps = true;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    dbus
    gsettings-qt
    icu
    libuchardet
  ] ++ lib.optionals withSystemd [ systemdLibs ];

  propagatedBuildInputs = [
    qt5.qtbase
    dtk5common
    dtklog
  ];

  postPatch = fixInstallPrefix;

  postInstall = ''
    moveToOutput "lib/qt5/mkspecs" "$dev"
  '';

  cmakeFlags = [
    (lib.cmakeBool "DTK5" true)
    (lib.cmakeBool "BUILD_WITH_SYSTEMD" withSystemd)
    (lib.cmakeBool "BUILD_DOCS" false)
  ];

  meta = {
    description = "GXDE DTK5 Core library";
    homepage = "https://github.com/GXDE-OS/dtk5core";
    license = with lib.licenses; [ lgpl3Plus lgpl21Plus bsd3 ];
    platforms = lib.platforms.linux;
  };
})
