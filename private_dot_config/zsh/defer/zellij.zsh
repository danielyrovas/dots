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

_zellij_auto_attach_2() {
    if [[ -z "$ZELLIJ" ]]; then
        # zellij attach --layout zjstatus -c experimental 
        zellij attach experimental 2&> /dev/null || zellij -s experimental -l zjstatus
    fi
}
alias ss=_zellij_auto_attach_2
