{ config, pkgs, zsh_plugins, ... }:
let
  aliases = {
    s = "zellij attach session --create";
    nv = "nvim";

# Verbosity settings
    cp = "cp -iv";
    mv = "mv -iv";
    rm = "rm -vI";
    bc = "bc -ql";
    mkd = "mkdir -pv";
    # "..." = "../..";

# Colourize commands when possible.
    # ls = "ls -h --color=auto"; not needed while using eza
    grep = "grep --color=auto";
    diff = "diff --color=auto";
    ccat = "highlight --out-format=ansi";
    ip = "ip -color=auto";

# Eza
    ls = "eza --group-directories-first --icons always";
    la = "ls -a";
    ll = "ls -lh --git";
    lla = "ll -a";
    tree = "ls -h --git --tree --level=2";

    gop = "gio open";
    c = "/usr/bin/clear -x";
    cls = "c && ls";
    clear = "tput reset";

    chez = "chezmoi";
    cheza = "chezmoi add";
    chezaddnvim = "chezmoi add ~/.config/nvim/init.lua;chezmoi add ~/.config/nvim/lua/;chezmoi add ~/.config/nvim/neoconf.json;chezmoi add ~/.config/nvim/spell/en.utf-8.add;chezmoi add ~/.config/nvim/lazy-lock.json";

    tl = "tldr --list | fzf --preview 'tldr {1} --color=always' --preview-window=right,70% | xargs tldr";

    rmquarantine = "xattr -d com.apple.quarantine";

    # rcat = "$(which cat)";
    # cat = "$(which bat)";
  };
  path = [
    "$HOME/bin"
    "$HOME/.local/bin"
    "$GOPATH/bin"
    "$GEM_HOME/bin"
    "$CARGO_HOME/bin"
    "$PNPM_HOME"
  ];
  env = {
# XDG Directories
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    HISTFILE = "$XDG_STATE_HOME/zsh/history";
    EDITOR = "nvim";
    NIX_PATH="$HOME/.nix-defexpr/channels";
    INPUTRC = "$XDG_CONFIG_HOME/shell/inputrc";

# Cleanup

    # ZDOTDIR = "$XDG_CONFIG_HOME/zsh";

    GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0";
    LESSHISTFILE = "$XDG_CACHE_HOME/less/history";
    WGETRC = "$XDG_CONFIG_HOME/wget/wgetrc";
    WINEPREFIX = "$XDG_DATA_HOME/wineprefixes/default";
    PASSWORD_STORE_DIR = "$XDG_DATA_HOME/password-store";
    TMUX_TMPDIR = "$XDG_RUNTIME_DIR";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    GOPATH = "$XDG_DATA_HOME/go";
    ANSIBLE_CONFIG = "$XDG_CONFIG_HOME/ansible/ansible.cfg";
    WEECHAT_HOME = "$XDG_CONFIG_HOME/weechat";
    MBSYNCRC = "$XDG_CONFIG_HOME/mbsync/config";
    ELECTRUMDIR = "$XDG_DATA_HOME/electrum";
    GNUPGHOME = "$XDG_DATA_HOME/gnupg";
    SOLARGRAPH_CACHE = "$XDG_DATA_HOME/solargraph";
    # ANDROID_HOME = "$XDG_DATA_HOME/android";
    # ANDROID_SDK_HOME = "$XDG_CONFIG_HOME/android";
    GEM_HOME = "$XDG_DATA_HOME/gem";
    GEM_SPEC_CACHE = "$XDG_CACHE_HOME/gem";
    GRADLE_USER_HOME = "$XDG_DATA_HOME/gradle";
    NODE_REPL_HISTORY = "$XDG_DATA_HOME/node_repl_history";
    NPM_CONFIG_USERCONFIG = "$XDG_CONFIG_HOME/npm/npmrc";
    PSQL_HISTORY = "$XDG_DATA_HOME/psql_history";
    BUNDLE_USER_CONFIG = "$XDG_CONFIG_HOME/bundle";
    BUNDLE_USER_CACHE = "$XDG_CACHE_HOME/bundle";
    BUNDLE_USER_PLUGIN = "$XDG_DATA_HOME/bundle";
    SQLITE_HISTORY = "$XDG_CACHE_HOME/sqlite_history";
    PNPM_HOME = "$XDG_DATA_HOME/pnpm";
    PKG_CACHE_PATH = "$XDG_CACHE_HOME/pnpm/pkg";

# App Settings
    FZF_DEFAULT_OPTS = "--layout=reverse --border"; # --height 40% ;
    # FZ_HISTORY_CD_CMD = "_zlua"; zoxide
  };
in
{
  nixpkgs.config = {
    allowUnfree = true;
    # Workaround for https://github.com/nix-community/home-manager/issues/2942
    allowUnfreePredicate = (_: true);
  };

  home.packages = with pkgs; [
    helix
    just
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    git
    chezmoi
    ripgrep
    bat
    fd
    sd
    neovim
    eza
    zsh-completions
    zoxide
    fzf
    # sheldon # no m1 build

    # Lsp servers
    nil
    lua-language-server
    yaml-language-server
    vscode-langservers-extracted
    dockerfile-language-server-nodejs
    ruby-lsp
    ruby
  ];


  programs.home-manager.enable = true;
  # programs.fish = {
  #   enable = false;
  #   shellAliases = aliases;
  #   plugins = [
  #     { name = "grc"; src = pkgs.fishPlugins.grc.src; }
  #   ];
  # };

  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = aliases;
    # histFile = "${config.xdg.dataHome}/zsh/history";
    initExtra = ''
      ${builtins.readFile ../private_dot_config/shell/zshrc}
    '';
    # plugins = with zsh_plugins; trace "++zsh plugin list: ${lib.concatMapStringsSep "," (x: x.name) plugin_list}" plugin_list;
    # plugins = [
    # {
    #   name = "zinsults";
    #   src = builtins.fetchTarball "https://github.com/ahmubashshir/zinsults/archive/master.tar.gz";
    # }
    #
    # ];
  };

  home = {
    # file = { };
    sessionVariables = env;
    sessionPath = path;
    stateVersion = "23.11";
  };
}
