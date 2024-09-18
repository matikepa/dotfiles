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

#set cool prompt
PROMPT='%{$fg[cyan]%}%d%{$reset_color%} $(git_prompt_info)'

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source <(npm completion)
# instead of doint this `nvm use 20`
# run this directi in console `nvm alias default 20`

# add exa complete
fpath=(~/.zfunc $fpath)
  
# aws cli autocomplete
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/opt/homebrew/bin/aws_completer' aws

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mati/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mati/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mati/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mati/google-cloud-sdk/completion.zsh.inc'; fi
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# kustomze completion
source <(kustomize completion zsh)
