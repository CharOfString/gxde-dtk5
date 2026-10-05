# GXDE DTK5 Gui

{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  qt5,
  kdePackages,
  libqtxdg,
  librsvg,
  wayland,
  wayland-scanner,
  dtk5common,
  dtk5core,
}:

let
  inherit (import ./lib.nix { inherit lib; }) fixInstallPrefix;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "dtkgui";
  version = "6.7.43";

  src = fetchFromGitHub {
    owner = "GXDE-OS";
    repo = "dtk5gui";
    rev = "2bd868437055c3f2487f8e5497eef0ae9ec834ac"; # tag 6.7.43
    hash = "sha256-R03436tqB/hLtTh68aOanYzr6Bkf4Icv0uis9VGJmY8=";
  };

  outputs = [ "out" "dev" ];

  dontWrapQtApps = true;

  nativeBuildInputs = [
    cmake
    pkg-config
    kdePackages.extra-cmake-modules
    wayland-scanner
  ];

  buildInputs = [
    librsvg
    libqtxdg
    wayland
  ];

  propagatedBuildInputs = [
    qt5.qtbase
    qt5.qtwayland
    libqtxdg
    dtk5common
    dtk5core
  ];

  postPatch = ''
    ${fixInstallPrefix}

    substituteInPlace src/kernel/kernel.cmake \
      --replace-fail '/usr/share/dsg/configs' '${dtk5common}/share/dsg/configs'
  '';

  postInstall = ''
    moveToOutput "lib/qt5/mkspecs" "$dev"
  '';

  cmakeFlags = [
    (lib.cmakeBool "DTK5" true)
    (lib.cmakeBool "BUILD_DOCS" false)
  ];

  meta = {
    description = "GXDE DTK5 Gui library";
    homepage = "https://github.com/GXDE-OS/dtk5gui";
    license = lib.licenses.lgpl3Plus;
    platforms = lib.platforms.linux;
  };
})
