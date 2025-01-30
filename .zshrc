# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/bin:$PATH"

# Set locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    aws
    dotenv
    macos
    docker
    docker-compose
)
source $ZSH/oh-my-zsh.sh

# #set cool prompt
# PROMPT='%{$fg[cyan]%}%d%{$reset_color%} $(git_prompt_info)'

## adding git branch info
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
## Multiline zsh commandline
PROMPT='%{$fg_bold[yellow]%}%n%{$reset_color%}@%{$fg_bold[cyan]%}%m%{$reset_color%} [%D{%H:%M:%S}]
%{$fg[green]%}%~%{$reset_color%} %{$fg[red]%}$(parse_git_branch)%{$reset_color%}
> '

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Custom functions
rollout-restart() {
  if [ -z "$1" ]; then
    echo "Error: No deployment name provided."
    echo "Available deployments:"
    kubectl get deployments
  else
    kubectl rollout restart deployment "$1" && kubectl rollout status deployment "$1" --watch
  fi
}

k_update() {
    LATEST_STABLE=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
    curl -L -o /tmp/kubectl https://storage.googleapis.com/kubernetes-release/release/$LATEST_STABLE/bin/darwin/arm64/kubectl
    chmod +x /tmp/kubectl
    mv /tmp/kubectl ~/bin/
    echo "> kubectl updated to $LATEST_STABLE"
}

