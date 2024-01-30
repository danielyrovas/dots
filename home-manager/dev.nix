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
    # entr
    # flyctl
    # ffmpeg
    # incus-unwrapped
    # zlib

    # Lsp servers
    nil
    lua-language-server
    yaml-language-server
    vscode-langservers-extracted
    dockerfile-language-server-nodejs
    ruby-lsp
    taplo

    # Dev environments
    # direnv nix-direnv
    ruby

    # pandoc
    # sc-im
  ];

  # programs.neovim.plugins = [
  #   pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  # ];
}
