export NVIM_APPNAME="nvim" # default config

alias nvchad="NVIM_APPNAME=NvChad nvim"
alias nvastro="NVIM_APPNAME=AstroNvim nvim"
alias nva="NVIM_APPNAME=AstroNvim nvim"
alias nvlazy="NVIM_APPNAME=LazyVim nvim"
alias nv="nvim"
alias nvc="NVIM_APPNAME=CosmicNvim nvim"

nvims() {
  items=("default" "nvim-kickstart" "LazyVim" "NvChad" "AstroNvim" "NvConf")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

alias nvs=nvims
