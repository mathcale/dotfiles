####
# @mathcale's ZSH shenanigans
####

####
# ZSH SETUP
####
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(sudo git wd history npm golang brew)

if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi
ZSH_DISABLE_COMPFIX=true
# zstyle ':omz:update' mode disabled

source $ZSH/oh-my-zsh.sh
[[ -f "$(brew --prefix)/share/zsh-autopair/zsh-autopair.zsh" ]] && source "$(brew --prefix)/share/zsh-autopair/zsh-autopair.zsh"

####
# GENERAL CONFIGS
####

PRIVATERC_FILE=~/.privaterc && test -f $PRIVATERC_FILE && source $PRIVATERC_FILE

export VISUAL="nvim"
export EDITOR="nvim"

# Aliases
alias dcu="docker compose up"
alias dcd="docker compose down"
alias nv=nvim
alias d=docker
alias l="eza --icons --color auto -lah"
alias ls="eza --icons --color auto --group-directories-first"
alias reset-hard="git reset --hard @{u}"
alias ff="fastfetch"
alias ka="killall"

# Shell alternatives configs
export BAT_THEME="Catppuccin Mocha"

# Local scripts
export PATH=$PATH:$HOME/.local/bin
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:$HOME/.cargo/bin

# HSTR
alias hh=hstr
setopt histignorespace
export HSTR_CONFIG=hicolor
export HSTR_PROMPT="Search: "
export HISTFILE=~/.zsh_history
hstr_no_tiocsti() {
  zle -I
  { HSTR_OUT="$( { </dev/tty hstr ${BUFFER}; } 2>&1 1>&3 3>&- )"; } 3>&1;
  BUFFER="${HSTR_OUT}"
  CURSOR=${#BUFFER}
  zle redisplay
}
zle -N hstr_no_tiocsti
bindkey '\C-r' hstr_no_tiocsti
export HSTR_TIOCSTI=n

# Fix kitty ssh shenanigans
export TERM=xterm-256color

export HOMEBREW_NO_ENV_HINTS=1

# Update kitty padding for certain apps
KITTY_PADDING_DEFAULT=4
KITTY_NO_PADDING_APPS=(opencode nvim)

_kitty_run_without_padding() {
  local cmd="$1"
  shift

  if [[ -n "$KITTY_WINDOW_ID" ]] && command -v kitty &>/dev/null; then
    kitty @ set-spacing padding=0 &>/dev/null

    command "$cmd" "$@"
    local exit_status=$?

    kitty @ set-spacing padding=$KITTY_PADDING_DEFAULT &>/dev/null

    return $exit_status
  else
    command "$cmd" "$@"
  fi
}

for _app in "${KITTY_NO_PADDING_APPS[@]}"; do
  eval "${_app}() { _kitty_run_without_padding ${_app} \"\$@\"; }"
done

unset _app

####
# PROGRAMMING-RELATED STUFF
####

# Go stuff
export GOPATH=$HOME/.goworkspace
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Android stuff
export ANDROID_HOME=$HOME/Library/Android/Sdk
export PATH=$PATH:$HOME/Library/Android/Sdk/emulator
export PATH=$PATH:$HOME/Library/Android/Sdk/tools
export PATH=$PATH:$HOME/Library/Android/Sdk/platform-tools
alias run-android="emulator @Honeywell_CT60_Emu_API_29"

# Node stuff
export NODE_OPTIONS=--max_old_space_size=4096
export REACT_EDITOR=code
export PATH="$HOME/Library/Application Support/fnm:$PATH"

eval "$(fnm env --use-on-cd)"

# Pi Pico stuff
export PICO_SDK_PATH="$HOME/Dev/embedded/pico-sdk"
export PICO_EXAMPLES_PATH="$HOME/Dev/embedded/pico-examples"
export PICO_EXTRAS_PATH="$HOME/Dev/embedded/pico-extras"

# bun stuff
export PATH="$HOME/.bun/bin:$PATH"
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# pnpm stuff
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# LM Studio stuff
export PATH="$PATH:$HOME/.lmstudio/bin"

eval "$(starship init zsh)"
