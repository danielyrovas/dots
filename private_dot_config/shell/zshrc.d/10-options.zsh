
HISTFILE=~/.cache/histfile
HISTSIZE=100000000
SAVEHIST=100000000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt extendedglob nomatch notify
unsetopt beep

# VI keymaps for line editing
bindkey -v
bindkey "^A"    beginning-of-line                    # ctrl-a
bindkey "^B"    backward-char                        # ctrl-b
bindkey "^E"    end-of-line                          # ctrl-e
bindkey "^[[3~" delete-char                          # DEL
bindkey "^N"    down-line-or-search                  # ctrl-n
bindkey "^P"    up-line-or-search                    # ctrl-p
bindkey "^R"    history-incremental-search-backward  # ctrl-r
bindkey "^[[B"  history-search-forward               # down arrow
bindkey "^[[A"  history-search-backward              # up arrow

autoload -U edit-command-line
zle -N edit-command-line
bindkey "^F" edit-command-line
bindkey -M vicmd "^F" edit-command-line
bindkey -M vicmd v edit-command-line

zstyle :compinstall filename '/home/danielyrovas/.config/shell/zshrc'
autoload -Uz compinit
compinit
