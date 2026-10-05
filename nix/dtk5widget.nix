# GXDE DTK5 Widget

{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  qt5,
  cups,
  gsettings-qt,
  xorg,
  libstartup_notification,
  dtk5core,
  dtk5gui,
}:

let
  inherit (import ./lib.nix { inherit lib; }) fixInstallPrefix;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "dtkwidget";
  version = "6.7.43";

  src = fetchFromGitHub {
    owner = "GXDE-OS";
    repo = "dtk5widget";
    rev = "dabd79120989c41345720d3b78ff900ff87bf3da";
    hash = "sha256-ZZteXEeoXq3x5nr1kaZMVRWceFLNpANQdEsKP2TW66Y=";
  };

  outputs = [ "out" "dev" ];

  dontWrapQtApps = true;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    cups
    gsettings-qt
    libstartup_notification
    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.xcbutil
    qt5.qttools
    qt5.qtsvg
  ];

  propagatedBuildInputs = [
    qt5.qtbase
    qt5.qtx11extras
    dtk5core
    dtk5gui
  ];

  postPatch = fixInstallPrefix;

  postInstall = ''
    moveToOutput "lib/qt5/mkspecs" "$dev"
    moveToOutput "lib/qt5/plugins" "$dev"
  '';

  cmakeFlags = [
    (lib.cmakeBool "DTK5" true)
    (lib.cmakeBool "BUILD_DOCS" false)
    (lib.cmakeBool "BUILD_EXAMPLES" false)
    (lib.cmakeBool "INSTALL_PLUGIN" true)
  ];

  meta = {
    description = "GXDE DTK5 Widget library";
    homepage = "https://github.com/GXDE-OS/dtk5widget";
    license = lib.licenses.lgpl3Plus;
    platforms = lib.platforms.linux;
  };
})
