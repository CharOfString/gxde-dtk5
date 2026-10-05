# GXDE DTK5 Log

{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  qt5,
  spdlog,
  systemdLibs,
  # JournalAppender 支持（libsystemd），与 Fedora/Debian 打包一致
  withSystemd ? stdenv.hostPlatform.isLinux,
}:

let
  inherit (import ./lib.nix { inherit lib; }) fixInstallPrefix;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "dtklog";
  version = "6.7.43";

  src = fetchFromGitHub {
    owner = "GXDE-OS";
    repo = "dtklog";
    rev = "f08a283e96e7e5cfce1286f038b315765dc58e36"; # tag 6.7.43
    hash = "sha256-pCCyTcScIuIsHyeYoj/DU9wgemk1eVRrV7LhBX9tRP8=";
  };

  outputs = [ "out" "dev" ];

  dontWrapQtApps = true;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    spdlog
  ] ++ lib.optionals withSystemd [ systemdLibs ];

  propagatedBuildInputs = [ qt5.qtbase ];

  postPatch = ''
    ${fixInstallPrefix}
    sed -i 's|include(CMakeFindDependencyMacro)|include(CMakeFindDependencyMacro)\nfind_dependency(Qt@QT_VERSION_MAJOR@ COMPONENTS Core)|' \
      misc/DLogConfig.cmake.in
  '';

  postInstall = ''
    moveToOutput "lib/qt5/mkspecs" "$dev"
  '';

  cmakeFlags = [
    (lib.cmakeBool "DTK5" true)
    (lib.cmakeBool "BUILD_WITH_SYSTEMD" withSystemd)
  ];

  meta = {
    description = "Simple, convenient and thread safe logger for Qt-based C++ applications (GXDE DTK5/Qt5)";
    homepage = "https://github.com/GXDE-OS/dtklog";
    license = lib.licenses.lgpl21Only;
    platforms = lib.platforms.linux;
  };
})
