{pkgs, ...}:
let
  treesitter = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.c p.nix p.bash p.markdown p.astro
    p.awk p.c_sharp p.clojure p.cmake p.comment p.cpp
    p.css p.cuda p.cue p.csv p.dart p.diff p.dockerfile 
    p.dot p.elixir p.elm p.elvish p.erlang p.fennel p.fish 
    p.gdscript p.git_config p.gitignore p.git_rebase
    p.gitattributes p.gleam p.gitcommit p.glimmer p.glsl
    p.godot_resource p.go p.gomod p.gosum p.gowork p.gpg
    p.graphql p.groovy p.hack p.hare p.haskell p.haskell_persistent
    p.hcl p.hjson p.hlsl p.hoon p.html p.htmldjango p.http
    p.hurl p.ini p.java p.javascript p.jq p.jsdoc p.json 
    p.json5 p.jsonc p.julia p.jsonnet p.kdl p.kotlin p.latex
    p.ledger p.leo p.llvm p.lua p.luadoc p.luap p.luau
    p.make p.markdown p.markdown_inline p.matlab p.meson
    p.nasm p.nickel p.nim p.nim_format_string p.ninja p.nix 
    p.norg p.objc p.objdump p.ocaml p.ocaml_interface
    p.odin p.org p.pascal p.passwd p.perl p.php
    p.phpdoc p.po p.pod p.pony p.printf p.prisma p.promql 
    p.proto p.psv p.pug p.puppet p.purescript p.pymanifest
    p.python p.ql p.qmldir p.qmljs p.query p.r p.racket
    p.rasi p.rbs p.regex p.rego p.robot p.ron p.rust p.rst p.ruby
    p.scala p.scheme p.slang p.slint p.smithy p.soql p.sparql
    p.sql p.ssh_config p.strace p.styled p.svelte p.sxhkdrc
    p.tablegen p.templ p.terraform p.textproto p.thrift
    p.tiger p.todotxt p.toml p.tsv p.tsx p.turtle p.twig
    p.typescript p.typoscript p.udev p.ungrammar p.v p.vala
    p.vhs p.vim p.vimdoc p.vue p.wgsl p.wgsl_bevy p.xcompose
    p.xml p.yaml p.yang p.yuck p.zig
  ]));

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitter.dependencies;
  };
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    plugins = with pkgs.vimPlugins; [ treesitter ];
  };

  home.packages = with pkgs; [
    tree-sitter

    # Lsp servers
    nil
    lua-language-server
    yaml-language-server
    vscode-langservers-extracted
    dockerfile-language-server-nodejs
    ruby-lsp
    taplo
  ];

  home.file.".config/nvim/lua/config/tspath.lua".text = ''
    -- Add Treesitter Plugin Path
    vim.opt.runtimepath:append("${pkgs.vimPlugins.nvim-treesitter}")
    -- Add Treesitter Parsers Path
    vim.opt.runtimepath:append("${treesitter-parsers}")
  '';
  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file.".local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitter;
  };
}
