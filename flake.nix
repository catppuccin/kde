{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    whiskers.url = "github:catppuccin/whiskers";
  };

  outputs =
    { self, nixpkgs, whiskers, ... }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      forEachSystem =
        function:
        nixpkgs.lib.genAttrs systems (
          system:
          function {
            inherit system;
            pkgs = nixpkgs.legacyPackages.${system};
          }
        );
    in
    {
      devShells = forEachSystem (
        { pkgs, system }:
        {
          default = pkgs.mkShell { packages = with pkgs; [ whiskers.packages.${system}.default ]; };
        }
      );

      formatter = forEachSystem ({ pkgs, ... }: pkgs.nixfmt-rfc-style);
    };

  nixConfig = {
    extra-substituters = [ "https://catppuccin.cachix.org" ];
    extra-trusted-public-keys = [
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
    ];
  };
}
