{
  description = "Home Manager configuration | Daniel";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim.url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "aarch64-darwin";
      username = "daniel.savory";
      hostname = "M1330";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ 
          ./home.nix
          ./${hostname}/${username}.nix
          ({
           nixpkgs.overlays = [inputs.neovim.overlay ];
          })
        ];
      };
    };
}
