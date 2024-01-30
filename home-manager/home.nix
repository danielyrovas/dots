{pkgs, ... }:
let
  aliases = {
    s = "zellij attach session --create";
    nv = "nvim";
    hms = "echo \"staging changes in $(pwd)\";git add .;home-manager switch --flake ."; # stage current changes and switch - must be in dir

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
    chezaddnvim = "chezmoi add ~/.config/nvim/lua/;chezmoi add ~/.config/nvim/neoconf.json;chezmoi add ~/.config/nvim/spell/en.utf-8.add;chezmoi add ~/.config/nvim/lazy-lock.json";

    tl = "tldr --list | fzf --preview 'tldr {1} --color=always' --preview-window=right,70% | xargs tldr";

    rmquarantine = "xattr -d com.apple.quarantine";
  };
in
{
  nixpkgs.config = {
    allowUnfree = true;
    # Workaround for https://github.com/nix-community/home-manager/issues/2942
    allowUnfreePredicate = (_: true);
  };

  home.packages = with pkgs; [
    # Basic packages
    just ripgrep eza bat fd sd zoxide fzf btop git
    chezmoi
    zellij
    bitwarden-cli
    vim
    zsh-completions
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # sheldon # no m1 build
  ];


  programs.home-manager.enable = true;
  xdg.enable = true;

  programs.bash = { enable = true; shellAliases = aliases; };

  programs.zsh = {
    enable = true;
    shellAliases = aliases;
    # histFile = "${config.xdg.dataHome}/zsh/history";
    initExtra = ''
      ${builtins.readFile config/zshrc}
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
    # sessionVariables = env;
    # sessionPath = path;
    stateVersion = "23.11";
  };
}
