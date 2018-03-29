#$ cat ~/.bashrc
# for the windows git-MINGW64

alias p='ping -t'
alias ll='ls -l'
alias ls='ls -F --color=auto --show-control-chars'
alias l='ls -lah'
alias grep='grep --color=auto'
alias temp='cd /c/temp/'
alias fullname='readlink -f'

# other usefull stuff
alias get-external-ip='curl -s ipinfo.io |tr -d "{}\""'
alias genpasswd='echo "Your new generated passwd: "; cat /dev/urandom  | head -n10 | sha512sum | base64 | head -c 10 ;echo'
alias download='curl -kLOC - '
alias weather='curl -s http://wttr.in/~vienna'

#git aliases
alias gs='git status'
alias gp='git pull --verbose'
alias gitupdate-localrepos='for i in $(ls -1 /c/temp/git-repos); do cd /c/temp/git-repos/$i ;echo "updating $i"; git pull ;done'

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
