{
  description = "Nix packaging of GXDE DTK5 (dtk5common, dtklog, dtk5core, dtk5gui, dtk5widget)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "riscv64-linux" ];
    in
    {
      overlays.default = final: prev: {
        dtk5 = import ./default.nix { pkgs = final; };
      };
    }
    // flake-utils.lib.eachSystem systems
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          packages = import ./default.nix { inherit pkgs; };
        in
        {
          inherit packages;
          checks.dtk5 = packages.all;
        });
}
