# Created by Zap installer
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "spaceship-prompt/spaceship-prompt"
plug "hlissner/zsh-autopair"
plug "zap-zsh/vim"
plug "chivalryq/zsh-autojump"

bindkey "^ " autosuggest-accept
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Spaceship config
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  rust          # Rust section
  venv          # virtualenv section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_PROMPT_SEPARATE_LINE="false"
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
SPACESHIP_CHAR_SYMBOL="$"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_USER_SHOW="always"
SPACESHIP_USER_PREFIX="["
SPACESHIP_USER_SUFFIX=""
SPACESHIP_HOST_SHOW="always"
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SUFFIX="] "
SPACESHIP_DIR_PREFIX=""
SPACESHIP_DIR_TRUNC=2
SPACESHIP_GIT_STATUS_SHOW="false"
SPACESHIP_GIT_PREFIX=""

# ALIASES
alias cat="bat"
alias ls="eza --icons"
alias l="eza -lag --icons"
alias gs="git status"
alias gl="git log"
alias gc="git clone"
alias gp="git push"
alias gd="git diff"
alias ga="git add -A"
alias vim="nvim"
alias cl="clear"
alias cal="cal -m"
alias neofetch="fastfetch"

# Display random pokemon :)
krabby random 1-5 --no-gmax
