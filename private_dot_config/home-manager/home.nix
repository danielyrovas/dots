{ config, pkgs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = [
    pkgs.helix
    pkgs.just
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.neovim
    pkgs.git
    pkgs.chezmoi
    pkgs.ripgrep
    pkgs.bat
    pkgs.fd
    pkgs.sd
  ];

  home.file = { 
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
 home.sessionPath = [ 
    "$HOME/bin"
    "$HOME/.local/bin"
    "$GOPATH/bin"
 ];
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
