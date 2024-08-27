###
# @mathcale's ZSH shenanigans
###

# Oh My ZSH configs
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="robbyrussell"
plugins=(git wd history npm sudo golang brew zsh-autopair)

source $ZSH/oh-my-zsh.sh

# Homebrew stuff
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Default terminal text editor
export EDITOR="lvim"

# Golang stuff
export GOPATH=$HOME/.goworkspace
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
# export GOPRIVATE=
# export GONOSUMDB=
export GOPROXY=https://proxy.golang.org,direct
# export GONOPROXY=
# export GOARCH=amd64

# Android
export ANDROID_HOME=$HOME/Library/Android/Sdk
export PATH=$PATH:$HOME/Library/Android/Sdk/emulator
export PATH=$PATH:$HOME/Library/Android/Sdk/tools
export PATH=$PATH:$HOME/Library/Android/Sdk/platform-tools
alias run-android="emulator @Honeywell_CT60_Emu_API_29"

# Node stuff
export NODE_OPTIONS=--max_old_space_size=4096
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export REACT_EDITOR=code
export PATH="$HOME/Library/Application Support/fnm:$PATH"
[[ $(command -v "fnm") ]] && eval "$(fnm env --use-on-cd --log-level=quiet)"

# Aliases
alias top=htop
alias dcu="docker compose up"
alias dcd="docker compose down"
alias vim=nvim
alias vi=nvim
alias d=docker
alias l="eza --icons --color auto -lah"
alias reset-hard="git reset --hard @{u}"
alias ka="killall"
alias nf="neofetch"
alias pf="pfetch"
alias kct="kubectl"
alias lzd="lazydocker"
alias lzg="lazygit"
alias yaegi='rlwrap yaegi'

# Shell alternatives configs
export BAT_THEME="Catppuccin Mocha"

# Local scripts
export PATH=$PATH:$HOME/.local/bin
export PATH="/usr/local/bin:$PATH"

# HSTR stuff
alias hh=hstr
setopt histignorespace
export HSTR_CONFIG=hicolor
export HSTR_PROMPT="Search: "
export HISTFILE=~/.zsh_history
bindkey -s "\C-r" "\C-a hstr -- \C-j"

# Import work-related stuff
[ -f ~/.workrc ] && source ~/.workrc

# Pyenv stuff
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Starship stuff
eval "$(starship init zsh)"
