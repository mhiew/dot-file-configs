## We rely on a few programs
# fzf - brew install fzf
# zoxide - brew install zoxide
# tmux - brew install tmux

## zsh changes for history
# increase history size
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
HISTDUP=erase

# automatically append to history file instead of on shell exit
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "

# add timestamps for history
setopt EXTENDED_HISTORY

# remove duplicates
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# share history between tabs
setopt SHARE_HISTORY

# hide macbook and username from prompt
PS1="%1d$ "

# automatically show extended options and the last 30 items
alias history="history -E -30"
alias allhistory="history -9999999"

###
# gradlew
alias gw="./gradlew"
alias gwp="./gradlew -p" #allows autocompletion

# reloads our shell with latest zshrc changes
alias mshell="source ~/.zshrc"

#use vim keybindings for shell commands
set -o vi

# always use ls with color
alias ls='ls --color'

alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
