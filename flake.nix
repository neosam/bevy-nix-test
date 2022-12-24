{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, flake-utils, naersk, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs) {
          inherit system;
        };

        naersk' = pkgs.callPackage naersk {};
        buildInputs = with pkgs; [
          udev alsaLib vulkan-loader
          xlibsWrapper xorg.libXcursor xorg.libXrandr xorg.libXi # To use x11 feature
          libxkbcommon wayland # To use wayland feature
        ];

      in rec {
        # For `nix build` & `nix run`:
        defaultPackage = naersk'.buildPackage {
          src = ./.;
          nativeBuildInputs = with pkgs; [
            pkg-config
            llvmPackages.bintools # To use lld linker
          ];
          buildInputs = buildInputs;
          postInstall = ./post_install.sh;
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
          appName = "bevy-nix-test";
        };

        # For `nix develop`:
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ rustc cargo ];
        };
      }
    );
}
