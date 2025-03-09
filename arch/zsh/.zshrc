####
# @mathcale's ZSH shenanigans
####

####
# ZSH SETUP
####
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(sudo git wd history npm golang)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh

if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi
autoload -Uz compinit
compinit

####
# GENERAL CONFIGS
####

PRIVATERC_FILE=~/.privaterc && test -f $PRIVATERC_FILE && source $PRIVATERC_FILE

export XDG_CONFIG_HOME=$HOME/.config

# Default terminal text editor
export VISUAL="lvim"
export EDITOR="lvim"

# thefuck stuff
eval $(thefuck --alias)
eval $(thefuck --alias FUCK)

# Aliases
alias dcu="docker compose up"
alias dcd="docker compose down"
alias vim=lvim
alias vi=lvim
alias lv=lvim
alias d=docker
alias ls="eza --icons --color auto --group-directories-first"
alias kct="kubectl"
alias ff="fastfetch"
alias lzd="lazydocker"
alias lzg="lazygit"
alias yaegi='rlwrap yaegi'

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

# Spicetify stuff
export PATH=$PATH:$HOME/.spicetify

# Set theme for GTK apps
export GTK_THEME="catppuccin-mocha-mauve-standard+default"

# Fix kitty ssh shenanigans
export TERM=xterm-256color

####
# PROGRAMMING-RELATED STUFF
####

# Java stuff
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

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
eval "`fnm env`"

# Pi Pico stuff
export PICO_SDK_PATH="$HOME/Dev/embedded/pico-sdk"
export PICO_EXAMPLES_PATH="$HOME/Dev/embedded/pico-examples"
export PICO_EXTRAS_PATH="$HOME/Dev/embedded/pico-extras"

# Deno stuff
. "$HOME/.deno/env"

# sst
export PATH=/home/mthx/.sst/bin:$PATH

# Init Starship prompt
eval "$(starship init zsh)"

nerdfetch
