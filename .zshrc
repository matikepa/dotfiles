# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
plugins=(git)
source $ZSH/oh-my-zsh.sh

#set cool prompt
PROMPT='%{$fg[cyan]%}%d%{$reset_color%} $(git_prompt_info)'

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mati/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mati/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mati/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mati/google-cloud-sdk/completion.zsh.inc'; fi
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# kustomze completion
source <(kustomize completion zsh)
