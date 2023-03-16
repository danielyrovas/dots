# Verbosity settings
alias \
  cp="cp -iv" \
  mv="mv -iv" \
  rm="rm -vI" \
  bc="bc -ql" \
  mkd="mkdir -pv"

# Colourize commands when possible.
alias \
  ls="ls -h --color=auto" \
  grep="grep --color=auto" \
  diff="diff --color=auto" \
  ccat="highlight --out-format=ansi" \
  ip="ip -color=auto"

  # ls="ls -hN --color=auto --group-directories-first"

alias \
  chez="chezmoi" \
  cheza="chezmoi add" \
  chezaddnvim="chezmoi add ~/.config/nvim/lua/custom"

alias \
  pacman="sudo pacman"
  p="pacman"

alias \
  nv="nvim"

alias \
    s='zellij attach session --create'

alias \
  tl="tldr --list | fzf --preview 'tldr {1} --color=always' --preview-window=right,70% | xargs tldr"

# Rust compile aliases
alias \
    crs="screen -mS $(basename $(pwd)) cargo run" \
    cre="screen -r $(basename $(pwd))" \
    crr="cargo run" \
    crc='cargo check' \
    crb='cargo build' \
    crt='cargo test'

# autocompile with gcc
_compile_c () {     
   gcc $1 -Wall -pedantic -std=c11 -lm -o ${1%.*}
}
_compile_debug_c () {     
   gcc $1 -Wall -DDEBUG -pedantic -std=c11 -lm -o ${1%.*}
}
alias \
    gc='_compile_c' \
    gcd='_compile_debug_c'

source_shell () {
    if [ ! -z ${ZSH_VERSION+x} ]; then
        echo "this is zsh"
        source ~/.zshrc
    elif [ ! -z ${BASH_VERSION+x} ]; then
        echo "this is bash"
        source ~/.bashrc
    else
        echo "Could not determine shell"
    fi
}
alias src='source_shell'

# Terminal
alias \
    ls='exa --group-directories-first --icons' \
    ll='ls -lh --git' \
    la='ll -a' \
    tree='ls -h --git --tree --level=2' \
    cls='clear -x && ls' \
    gop='gio open' \
    c='clear -x' \
    hx='helix'

## LXD ##
#lxcsh() { lxc exec "$1" -- sudo --login --user $2; }
function lxcsh() {
        XT=$TERM
    TERM=xterm-256color
    command lxc exec "$1" -- su $2;
    TERM=$XT
}

function lxg() {
        XT=$TERM
    TERM=xterm-256color
    command lxc exec "$1" -- sudo --user $2 --login;
    TERM=$XT
}

# call this function with the command and then $@
# function prevent_garbage_kitty_term() {
#   TERM=xterm-256color
#         command $@
#   TERM=xterm-kitty
# }
# eg:
#alias lxc="prevent_garbage_kitty_term lxc $@"
#alias ssh="prevent_garbage_kitty_term ssh $@"

# Temp aliases
# Server
alias srv='ssh lxc@192.168.1.10'
alias spi='ssh lxc@192.168.1.32'
