export ZSH="/home/matheus.calegaro/.oh-my-zsh"

ZSH_THEME="spaceship"
plugins=(git wd aws command-not-found gradle history jira npm sublime sudo vscode yarn)

source $ZSH/oh-my-zsh.sh

# Default terminal text editor
export EDITOR="vim"

# Gradle
export PATH=$PATH:/opt/gradle/gradle-2.3/bin

# SDKMan
export SDKMAN_DIR="/home/matheus.calegaro/.sdkman"
[[ -s "/home/matheus.calegaro/.sdkman/bin/sdkman-init.sh" ]] && source "/home/matheus.calegaro/.sdkman/bin/sdkman-init.sh"

# thefuck
eval $(thefuck --alias)

# Config do Hydra
export PATH=$PATH:/home/matheus.calegaro/Projetos/hydra/lasa-hydra/scripts

# Go
export GOPATH=/home/matheus.calegaro/go-workspace
export PATH=$PATH:/home/matheus.calegaro/.go/bin
export PATH=$PATH:$GOPATH/bin

# Localstack
export DATA_DIR=/tmp/localstack/data
export DYNAMO_ENDPOINT=http://localhost:4569

#Android
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_NDK_HOME=$HOME/Android/Sdk/ndk-bundle
export PATH=$PATH:/home/matheus.calegaro/Android/Sdk/tools
export PATH=$PATH:/home/matheus.calegaro/Android/Sdk/platform-tools
#export PATH=$PATH:/home/matheus.calegaro/Android/Sdk/emulator

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

alias run-android="cd $HOME/Android/Sdk/emulator && ./emulator @Oreo27 && cd -"

export REACT_EDITOR=code

