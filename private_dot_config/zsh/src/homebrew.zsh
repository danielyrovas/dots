if command -v /opt/homebrew/bin/brew &> /dev/null
then
    export HOMEBREW_CASK_OPTS="--no-quarantine"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
