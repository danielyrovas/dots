autoload -Uz compinit
compinit

zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
zle_highlight=('paste:none')

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' file-sort access
zstyle ':completion:*' ignore-parents parent pwd directory
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 1
# zstyle ':completion:*' menu select=long
zstyle ':completion:*' menu yes select
zstyle ':completion:*' original true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '~/.config/zsh/.zshrc'

compinit -C
