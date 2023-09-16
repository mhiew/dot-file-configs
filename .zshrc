
### zsh changes for history
# increase history size
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# automatically append to history file instead of on shell exit
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "

# add timestamps for history
setopt EXTENDED_HISTORY

# remove duplicates
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

# share history between tabs
setopt SHARE_HISTORY

# automatically show extended options and the last 30 items
alias history="history -E -30"

###
# gradlew
alias gw="./gradlew"
alias gwp="./gradlew -p" #allows autocompletion

# reloads our shell with latest zshrc changes
alias mshell="source ~/.zshrc"

