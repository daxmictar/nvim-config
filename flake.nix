{
  description = "Neovim Flake";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fenix.url = "github:nix-community/fenix";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, ... }:

        let
          # Fenix Rust toolchain
          rustToolchain = inputs.fenix.packages.${pkgs.stdenv.hostPlatform.system}.stable.withComponents [
            "cargo"
            "clippy"
            "rust-src"
            "rustc"
            "rustfmt"
          ];

        in

        {
          devShells = {
            default = pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
              packages = with pkgs; [
			  	# fennel packages
			  	luajitPackages.fennel
				fennel-ls
				fnlfmt
				# rust
			  	rustToolchain
				# c + buildsystem
                clang-tools
                cmake
              ];
            };
          };
        };
    };
}
