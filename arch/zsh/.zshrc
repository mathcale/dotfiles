####
# @mathcale's ZSH shenanigans
####

####
# ZSH SETUP
####
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(sudo git wd history npm yarn golang)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh

####
# GENERAL CONFIGS
####

# Default terminal text editor
export VISUAL="nvim"
export EDITOR="nvim"

# thefuck stuff
eval $(thefuck --alias)
eval $(thefuck --alias FUCK)

# Aliases
alias top=htop
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias vim=nvim
alias vi=nvim
alias d=docker
alias ls="eza --icons --color auto"
alias kct="kubectl"
alias nf="neofetch"
alias pf="pfetch"
alias lzd="lazydocker"
alias lzg="lazygit"
alias yaegi='rlwrap yaegi'

# Shell alternatives configs
export BAT_THEME="Dracula"

# Local scripts
export PATH=$PATH:$HOME/.local/bin
export PATH="/usr/local/bin:$PATH"

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

# pfetch stuff
export PF_INFO="ascii os host memory pkgs shell editor"

# Spicetify stuff
export PATH=$PATH:$HOME/.spicetify

# Quickemu stuff
export PATH=$PATH:$HOME/Apps/quickemu

# Set theme for GTK apps
export GTK_THEME='Catppuccin-Mocha-Standard-Mauve-Dark'

# Fix kitty ssh shenanigans
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

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

# Node stuff
export REACT_EDITOR=code
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/share/fnm:$PATH"
eval "`fnm env`"

# Pi Pico stuff
export PICO_SDK_PATH="$HOME/Dev/embedded/pico-sdk"
export PICO_EXAMPLES_PATH="$HOME/Dev/embedded/pico-examples"
export PICO_EXTRAS_PATH="$HOME/Dev/embedded/pico-extras"

# Rust stuff
source "$HOME/.cargo/env"

# Init Starship prompt
eval "$(starship init zsh)"
