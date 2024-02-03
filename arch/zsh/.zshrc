###
# @mathcale's ZSH shenanigans
###

# Oh My ZSH configs
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(sudo git wd history npm yarn)

source $ZSH/oh-my-zsh.sh

# Default terminal text editor
export VISUAL="nvim"
export EDITOR="nvim"

# SDKMan stuff
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# thefuck stuff
eval $(thefuck --alias)
eval $(thefuck --alias FUCK)

# Go stuff
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/.goworkspace
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Localstack stuff
export DATA_DIR=/tmp/localstack/data
export DYNAMO_ENDPOINT=http://localhost:8000

# Android stuff
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$HOME/Android/Sdk/emulator
export PATH=$PATH:$HOME/Android/Sdk/tools
export PATH=$PATH:$HOME/Android/Sdk/platform-tools

# NVM/Node stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export NODE_OPTIONS=--max_old_space_size=4096

autoload -U add-zsh-hook

load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# React Native stuff
export REACT_EDITOR=code

# Aliases
alias d="docker"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias vim=nvim
alias vi=nvim
alias ls="eza --icons --color auto"
alias kct="kubectl"
alias nf="neofetch"
alias pf="pfetch"
alias lzd="lazydocker"

# Shell alternatives configs
export BAT_THEME="Dracula"

# Serverless/SAM stuff
export SAM_CLI_TELEMETRY=0
export PATH="$HOME/.serverless/bin:$PATH"

# Yarn binaries
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Local scripts
export PATH=$PATH:$HOME/.local/bin
export PATH="/usr/local/bin:$PATH"

# jEnv stuff
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# HSTR stuff
alias hh=hstr
setopt histignorespace
export HSTR_CONFIG=hicolor
bindkey -s "\C-r" "\C-a hstr -- \C-j"

# pfetch stuff
export PF_INFO="ascii os host memory pkgs shell editor"

# Pi Pico stuff
export PICO_SDK_PATH="$HOME/Dev/embedded/pico-sdk"
export PICO_EXAMPLES_PATH="$HOME/Dev/embedded/pico-examples"
export PICO_EXTRAS_PATH="$HOME/Dev/embedded/pico-extras"

# Spicetify stuff
export PATH=$PATH:$HOME/.spicetify

export GTK_THEME='Catppuccin-Frappe-Standard-Mauve-Dark:dark'

# Google Cloud SDK stuff.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Disable buildkit
export DOCKER_BUILDKIT=0

# Fix kitty ssh shenanigans
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# Init autopair plugin
source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh

# Starship stuff
eval "$(starship init zsh)"
