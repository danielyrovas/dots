
HISTFILE=~/.cache/histfile
HISTSIZE=100000
SAVEHIST=100000
setopt extendedglob nomatch notify
unsetopt beep
bindkey -v

zstyle :compinstall filename '/home/danielyrovas/.config/shell/zshrc'
autoload -Uz compinit
compinit
