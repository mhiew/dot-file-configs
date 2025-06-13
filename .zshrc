## We rely on a few programs
# fzf - brew install fzf
# zoxide - brew install zoxide
# tmux - brew install tmux
# fd - brew install fd
# bat - brew install bat

DIR="$(dirname "$(realpath "$0")")"

# disable zsh beep sound
unsetopt beep

## press ctrl-v to edit command line in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

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
#PS1="%1d$

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
#set -o vi

# always use ls with color
alias ls='ls --color'

alias c='clear; tmux clear-history'

# git helpers (requires fzf)
#fuzzy search over branches
alias fsb='${DIR}/scripts/fsb.sh'
#fuzzy search over commits
alias fsc='${DIR}/scripts/fsc.sh'

function gitamend {
    if [ -z "$1" ]; then
        git commit --amend --no-edit;
    else 
        git commit --amend -m "$@";
    fi;
}
alias lg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --simplify-by-decoration"
alias lg1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --simplify-by-decoration"

# faster git status but does not view untracked files
alias gitfstatus="git status -uno"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

#fzf configs
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

