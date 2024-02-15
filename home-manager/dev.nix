{ pkgs, ... }:
{
  home.packages = with pkgs; [
    helix
    cosign
    tea
    tealdeer
    ouch
    gitui
    yq-go
    jq
    gradle
    gh
    glow
    visidata
    wireguard-tools
    watchexec
    gitmux
    atuin
    delta
    # starship
    # entr
    flyctl
    # ffmpeg
    # incus-unwrapped
    # zlib

    # Dev environments
    # direnv nix-direnv
    ruby

    # pandoc
    # sc-im

    # JavaScript
    # nodePackages_latest.pnpm
    # nodePackages_latest.nodejs
  ];

  # programs.neovim.plugins = [
  #   pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  # ];
}
