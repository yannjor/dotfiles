export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

export PATH="$PATH:$CARGO_HOME/bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$GOPATH/bin"

# Default programs
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="librewolf"
