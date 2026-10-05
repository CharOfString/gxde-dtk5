# GXDE DTK5

{ pkgs ? import <nixpkgs> { } }:

let
  inherit (pkgs) lib;

  dtk5common = pkgs.callPackage ./nix/dtk5common.nix { };

  dtklog = pkgs.callPackage ./nix/dtklog.nix { };

  dtk5core = pkgs.callPackage ./nix/dtk5core.nix {
    inherit dtk5common dtklog;
  };

  dtk5gui = pkgs.callPackage ./nix/dtk5gui.nix {
    inherit dtk5common dtk5core;
    libqtxdg = pkgs.lxqt.libqtxdg_3_12;
  };

  dtk5widget = pkgs.callPackage ./nix/dtk5widget.nix {
    inherit dtk5core dtk5gui;
  };

  all = pkgs.symlinkJoin {
    name = "dtk5-${dtk5widget.version}";
    paths = lib.concatMap (p: [ p p.dev ]) [
      dtk5common
      dtklog
      dtk5core
      dtk5gui
      dtk5widget
    ];
  };
in
{
  inherit
    dtk5common
    dtklog
    dtk5core
    dtk5gui
    dtk5widget
    all
    ;

  default = all;
}
