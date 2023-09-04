# eval "$(zellij setup --generate-auto-start zsh)"
# export ZELLIJ_AUTO_ATTACH=true
# if [[ -z "$ZELLIJ" ]]; then
#     if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
#         zellij attach -c
#     else
#         zellij
#     fi
#
#     if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
#         exit
#     fi
# fi

## Auto attach to zellij session
_zellij_auto_attach() {
    if [[ -z "$ZELLIJ" ]]; then
        zellij attach -c session
    fi
}
alias s=_zellij_auto_attach
