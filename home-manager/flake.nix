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
      work.username = "daniel.savory";
      work.system = "aarch64-darwin";
      work.hostname = "M1330";
      desktop.username = "danielyrovas";
      desktop.system = "x86_64-linux";
      desktop.hostname = "desktop";
    in {
      homeConfigurations.${work.username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${work.system};

        modules = [ 
          ./home.nix
          ./dev.nix
          ./neovim.nix
          ./${work.username}-${work.hostname}.nix
          ({
           nixpkgs.overlays = [inputs.neovim.overlay ];
          })
        ];
      };
      homeConfigurations.${desktop.username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${desktop.system};

        modules = [ 
          ./home.nix
          ./dev.nix
          ./gui.nix # maybe ?
          ./${desktop.username}-${desktop.hostname}.nix
          ({
           nixpkgs.overlays = [inputs.neovim.overlay ];
          })
        ];
      };
    };
}
