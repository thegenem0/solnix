{
  description = "solnix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awsvpnclient.url = "github:ymatsiuk/awsvpnclient";
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "thinkpad";
      username = "solinaire";
    in
    {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
	    inherit system;
            inherit inputs;
            inherit username;
            inherit host;
          };
          modules = [
            {
              nixpkgs.overlays = [
                inputs.rust-overlay.overlays.default
                # Thanks AWS, I love to have to do this...
                (final: prev: {
                  openvpn_2_5 = prev.openvpn_2_5 or (prev.openvpn.overrideAttrs (oldAttrs: {
                    version = "2.5.1";
                    src = prev.fetchurl {
                      url = "https://swupdate.openvpn.org/community/releases/openvpn-2.5.1.tar.gz";
                      sha256 = "sha256-6VgrjpRXmUvY1QASvoLCOy9GXaUUYMmyNgqB2g9OBuY=";
                    };
                    patches = [
                      (prev.fetchpatch {
                        url =
                          "https://raw.githubusercontent.com/samm-git/aws-vpn-client/master/openvpn-v2.5.1-aws.patch";
                        hash = "sha256-9ijhANqqWXVPa00RBCRACtMIsjiBqYVa91V62L4mNas=";
                      })
                    ];
                  }));
                  awsvpnclient = inputs.awsvpnclient.packages.${system}.awsvpnclient.override {
                    openvpn = final.openvpn_2_5;
                  };
                })
              ];
            }
            ./hosts/${host}/config.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit username;
                inherit inputs;
                inherit host;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${username} = import ./hosts/${host}/home.nix;
            }
          ];
        };
      };
    };
}
