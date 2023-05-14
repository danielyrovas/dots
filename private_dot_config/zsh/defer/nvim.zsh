export NVIM_APPNAME="NvChad" # default config

alias nvkick="NVIM_APPNAME=nvim-kickstart nvim"
alias nvchad="NVIM_APPNAME=NvChad nvim"
alias nvastro="NVIM_APPNAME=AstroNvim nvim"
alias nvlazy="NVIM_APPNAME=LazyVim nvim"

# nvims() {
#   items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
#   config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
#   if [[ -z $config ]]; then
#     echo "Nothing selected"
#     return 0
#   elif [[ $config == "default" ]]; then
#     config=""
#   fi
#   NVIM_APPNAME=$config nvim $@
# }

# alias nvs=nvims
# bindkey "^w" nvims
