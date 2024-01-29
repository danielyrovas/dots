{ pkgs, ... }:
{
  home.packages = with pkgs; [
    helix

    # Lsp servers
    nil
    lua-language-server
    yaml-language-server
    vscode-langservers-extracted
    dockerfile-language-server-nodejs
    ruby-lsp

    # Dev environments
    # direnv nix-direnv
    ruby
  ];
}
