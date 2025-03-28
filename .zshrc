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

# Enable prompt substitution
setopt PROMPT_SUBST

## Kubernetes prompt function (using context name)
kube_prompt_info() {
  command -v kubectl &>/dev/null || return
  local kube_context=$(kubectl config current-context 2>/dev/null)
  [[ -z "$kube_context" ]] && return

  local context_name=$(kubectl config view --minify -o jsonpath='{.contexts[0].name}' 2>/dev/null)
  local namespace=$(kubectl config view --minify -o jsonpath='{.contexts[0].context.namespace}' 2>/dev/null)
  [[ -z "$namespace" ]] && namespace="default"

  echo -n "%{$fg[blue]%}⎈ %{$fg_bold[green]%}${context_name}%{$fg[red]%}:%{$fg[magenta]%}${namespace}%{$reset_color%}"
}

## adding git branch info
parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Modified prompt with Kubernetes at top line
PROMPT='
%{$fg_bold[yellow]%}%n%{$reset_color%}@%{$fg_bold[cyan]%}%m%{$reset_color%} [%D{%H:%M:%S}] | $(kube_prompt_info)
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

# Keybinding - needs to be set also in iterm2
# Bind Cmd + Left Arrow to move one word back
bindkey '\eb' backward-word
# Bind Cmd + Right Arrow to move one word forward
bindkey '\ef' forward-word
# Bind Cmd + Left Arrow to move to the beginning of the line
bindkey '\ea' beginning-of-line
# Bind Cmd + Right Arrow to move to the end of the line
bindkey '\ee' end-of-line

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

k9s_update() {
    set -eo pipefail

    # Detect OS and architecture dynamically
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    case $(uname -m) in
        x86_64) ARCH="amd64" ;;
        arm64)  ARCH="arm64" ;;
        *)      echo "Unsupported architecture"; return 1 ;;
    esac

    # Let user select version
    local TAG
    TAG=$(git ls-remote --tags https://github.com/derailed/k9s.git |
        awk -F'/' '/refs\/tags\// {print $3}' |
        grep -v '\^{}$' |
        sort -rV |
        fzf --prompt="Select k9s version: ")

    [ -z "$TAG" ] && echo "No version selected" && return 1

    # Create temporary workspace
    local TMP_DIR
    TMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TMP_DIR"' EXIT

    # Download and extract
    echo "▹ Downloading k9s $TAG..."
    if ! curl -#L "https://github.com/derailed/k9s/releases/download/$TAG/k9s_${OS}_${ARCH}.tar.gz" \
        -o "$TMP_DIR/k9s.tar.gz"; then
        echo "Download failed"
        return 1
    fi

    tar -xzf "$TMP_DIR/k9s.tar.gz" -C "$TMP_DIR"

    # Locate binary and verify
    local BINARY_PATH="$TMP_DIR/k9s"
    [ ! -f "$BINARY_PATH" ] && BINARY_PATH=$(find "$TMP_DIR" -name k9s -type f -print -quit)
    [ ! -x "$BINARY_PATH" ] && echo "Binary not found or executable" && return 1

    # Install to user's bin directory
    local BIN_DIR="${HOME}/bin"
    mkdir -p "$BIN_DIR"
    chmod +x "$BINARY_PATH"
    mv -f "$BINARY_PATH" "$BIN_DIR/"

    echo "✓ k9s updated to ${TAG}"
    "${BIN_DIR}/k9s" version
}
