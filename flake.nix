{
  description = "Flake for ObjectDiff library for Pharo";

  inputs = rec {
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    pharo-vm-12 = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:rydnr/nix-flakes/pharo-vm-12.0.1519.4?dir=pharo-vm";
    };
  };
  outputs = inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let
        org = "rydnr";
        repo = "object-diff";
        pname = "${repo}";
        tag = "0.1.1";
        baseline = "ObjectDiff";
        pkgs = import nixpkgs { inherit system; };
        description = "An object diff library in Pharo";
        license = pkgs.lib.licenses.gpl3;
        homepage = "https://github.com/rydnr/object-diff";
        maintainers = with pkgs.lib.maintainers; [ ];
        nixpkgsVersion = builtins.readFile "${nixpkgs}/.version";
        nixpkgsRelease =
          builtins.replaceStrings [ "\n" ] [ "" ] "nixpkgs-${nixpkgsVersion}";
        shared = import ./nix/shared.nix;
        rydnr-object-diff-for = { bootstrap-image-name, bootstrap-image-sha256, bootstrap-image-url, pharo-vm }:
          let
            bootstrap-image = pkgs.fetchurl {
              url = bootstrap-image-url;
              sha256 = bootstrap-image-sha256;
            };
            src = ./src;
          in pkgs.stdenv.mkDerivation (finalAttrs: {
            version = tag;
            inherit pname src;

            strictDeps = true;

            buildInputs = with pkgs; [
            ];

            nativeBuildInputs = with pkgs; [
              pharo-vm
              pkgs.unzip
            ];

            unpackPhase = ''
              unzip -o ${bootstrap-image} -d image
              # cp -r ${src} src
            '';

            configurePhase = ''
              runHook preConfigure

              # load baseline
              ${pharo-vm}/bin/pharo image/${bootstrap-image-name} eval --save "EpMonitor current disable. NonInteractiveTranscript stdout install. [ Metacello new repository: 'tonel://${src}'; baseline: '${baseline}'; onConflictUseLoaded; load ] ensure: [ EpMonitor current enable ]"

              runHook postConfigure
            '';

            buildPhase = ''
              runHook preBuild

              # assemble
              ${pharo-vm}/bin/pharo image/${bootstrap-image-name} save "${pname}"

              mkdir dist
              mv image/${pname}.* dist/

              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall

              mkdir -p $out
              cp -r ${pharo-vm}/bin $out
              cp -r ${pharo-vm}/lib $out
              cp -r dist/* $out/
              cp image/*.sources $out/
              mkdir $out/share
              pushd ${src}
              ${pkgs.zip}/bin/zip -r $out/share/src.zip .
              popd

              runHook postInstall
             '';

            meta = {
              changelog = "https://github.com/rydnr/object-diff/releases/";
              longDescription = ''
                    An object diff framework in Pharo.
              '';
              inherit description homepage license maintainers;
              mainProgram = "pharo";
              platforms = pkgs.lib.platforms.linux;
            };
        });
      in rec {
        defaultPackage = packages.default;
        devShells = rec {
          default = rydnr-object-diff-12;
          rydnr-object-diff-12 = shared.devShell-for {
            package = packages.rydnr-object-diff-12;
            inherit org pkgs repo tag;
            nixpkgs-release = nixpkgsRelease;
          };
        };
        packages = rec {
          default = rydnr-object-diff-12;
          rydnr-object-diff-12 = rydnr-object-diff-for rec {
            bootstrap-image-url = pharo-vm-12.resources.${system}.bootstrap-image-url;
            bootstrap-image-sha256 = pharo-vm-12.resources.${system}.bootstrap-image-sha256;
            bootstrap-image-name = pharo-vm-12.resources.${system}.bootstrap-image-name;
            pharo-vm = pharo-vm-12.packages.${system}.pharo-vm;
          };
        };
      });
}
