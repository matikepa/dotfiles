#$ cat ~/.bashrc

alias temp='cd /c/temp/'
alias gs='git status'
alias extip='curl -s ipinfo.io |tr -d '{}\"''
alias p='ping -t'
alias fullname='readlink -f'
alias passwd-gen='echo "Your new generated passwd: "; date +%s | sha256sum | base64 | head -c 15;echo'
alias download='curl -kLOC - '

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
