{
  description = "Flake to provide packages from the open source radio catalog";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = pkgs.lib.packagesFromDirectoryRecursive {
          inherit (pkgs) callPackage;
          directory = ./pkgs;
        };
      };
    };
}
