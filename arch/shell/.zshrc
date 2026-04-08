####
# @mathcale's ZSH shenanigans
####

####
# ZSH SETUP
####
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(sudo git wd history npm golang)

if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi
ZSH_DISABLE_COMPFIX=true
# zstyle ':omz:update' mode disabled

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh

####
# GENERAL CONFIGS
####

PRIVATERC_FILE=~/.privaterc && test -f $PRIVATERC_FILE && source $PRIVATERC_FILE

export XDG_CONFIG_HOME=$HOME/.config

# Default terminal text editor
export VISUAL="nvim"
export EDITOR="nvim"

# Aliases
alias dcu="docker compose up"
alias dcd="docker compose down"
alias nv=nvim
alias d=docker
alias ls="eza --icons --color auto --group-directories-first"
alias nf="nerdfetch"

# Shell alternatives configs
export BAT_THEME="Catppuccin Mocha"

# Local scripts
export PATH=$PATH:$HOME/.local/bin
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:$HOME/.cargo/bin

# HSTR stuff
alias hh=hstr
setopt histignorespace
export HSTR_CONFIG=hicolor
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

# Set GTK apps theme
export GTK_THEME="Catppuccin-Purple-Dark"

# Fix kitty ssh shenanigans
export TERM=xterm-256color

# ROCm stuff
export ROCM_PATH=/opt/rocm
export HSA_OVERRIDE_GFX_VERSION=10.3.0

####
# PROGRAMMING-RELATED STUFF
####

# Java stuff
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="$HOME/.jenv/bin:$PATH"

_jenv_init() {
  unfunction java javac jenv 2>/dev/null
  eval "$(jenv init -)"
}

java()  { _jenv_init; java  "$@"; }
javac() { _jenv_init; javac "$@"; }
jenv()  { _jenv_init; jenv  "$@"; }

# Go stuff
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/.goworkspace
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Android stuff
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$HOME/Android/Sdk/emulator
export PATH=$PATH:$HOME/Android/Sdk/tools
export PATH=$PATH:$HOME/Android/Sdk/platform-tools
alias run-emu="emulator @pixel8_38 -logcat '*:d' > /var/log/android-emulator.log 2>&1"

# Node stuff
export REACT_EDITOR=code
export PATH="$HOME/.npm-global/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/share/fnm:$PATH"

_fnm_init() {
  unfunction node npm npx yarn pnpm bun 2>/dev/null
  eval "$(fnm env --use-on-cd)"
}

node() { _fnm_init; node  "$@"; }
npm()  { _fnm_init; npm   "$@"; }
npx()  { _fnm_init; npx   "$@"; }
yarn() { _fnm_init; yarn  "$@"; }
pnpm() { _fnm_init; pnpm  "$@"; }
bun()  { _fnm_init; bun   "$@"; }

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

# Init Starship prompt
eval "$(starship init zsh)"
