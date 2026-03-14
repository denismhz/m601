{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  inputs.nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
  }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
    pkgs-unstable = import nixpkgs-unstable {system = "x86_64-linux";};
    pythonPackages = pkgs.python311Packages;
    pyPkgs = with pythonPackages; [
      pyusb
      pip
    ];
  in {
    devShells.x86_64-linux = {
      default = pkgs.mkShell {
        buildInputs = [
          pyPkgs
        ];
        shellHook = ''
          source venv/bin/activate
        '';
      };
    };
  };
}
