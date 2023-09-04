# if ! command -v broot &> /dev/null
# then
#     exit
# fi

# function br {
#     local cmd cmd_file code
#     cmd_file=$(mktemp)
#     if broot --outcmd "$cmd_file" "$@"; then
#         cmd=$(<"$cmd_file")
#         rm -f "$cmd_file" &>/dev/null
#         eval "$cmd"
#     else
#         code=$?
#         rm -f "$cmd_file"
#         return "$code"
#     fi
# }
#
# function tre {
#      br -c :pt "$@"
# }

# alias bs="br --conf ~/.config/broot/select.toml"
