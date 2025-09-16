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

## Terraform workspace function
tf_workspace() {
  command -v terraform &>/dev/null || return
  local workspace=$(terraform workspace show 2>/dev/null)
  [[ -z "$workspace" ]] && return
  echo -n "🧱 %{$FG[141]%}${workspace}%{$reset_color%}"
}

# Modified prompt with Kubernetes at top line
PROMPT='
%{$fg_bold[yellow]%}%n%{$reset_color%}@%{$fg_bold[cyan]%}%m%{$reset_color%} [%D{%H:%M:%S}] | $(kube_prompt_info) | $(tf_workspace)
%{$fg[green]%}%~%{$reset_color%} %{$fg[red]%}$(parse_git_branch)%{$reset_color%}
> '

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Then source your aliases file
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi

# Export some custom functions to separate file
if [ -f ~/.zsh_functions ]; then
  . ~/.zsh_functions
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

# ---------------------
# Eternal zsh history.
# ---------------------
# Based on https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh
# ---------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
