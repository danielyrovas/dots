# VI keymaps for line editing
bindkey -v
bindkey "^A"    beginning-of-line                    # ctrl-a
bindkey "^E"    end-of-line                          # ctrl-e
bindkey "^[[3~" delete-char                          # DEL
bindkey "^[[B"  down-line-or-search                  # ctrl-n
bindkey "^[[A"  up-line-or-search                    # ctrl-p
# bindkey "^R"    history-incremental-search-backward  # ctrl-r
bindkey "^N"    history-search-forward               # down arrow
bindkey "^P"    history-search-backward              # up arrow

autoload -U edit-command-line
zle -N edit-command-line
bindkey "^F" edit-command-line
bindkey -M vicmd "^F" edit-command-line
bindkey -M vicmd v edit-command-line

# zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"
autoload -Uz compinit
compinit
