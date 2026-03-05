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

## unbind ctrl-g (default: send-break which clears current input)
## ctrl-c already provides the same behavior, so this avoids accidental clears
bindkey -r '^g'

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

# ability to see git trace information
alias gittrace="GIT_TRACE=1 GIT_TRACE_PERFORMANCE=1 git"

### Shell Prompt Configuration
# Enable function execution inside the prompt
setopt PROMPT_SUBST

parse_git_branch() {
    # Get current branch name
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    
    if [[ -n "$branch" ]]; then
        local git_status=$(git status --porcelain 2>/dev/null)
        local indicators=""

        # STAGED (+): Dracula Green (#50fa7b)
        # Matches any change in the first column of porcelain output
        if echo "$git_status" | grep -q "^[MADRC]"; then
            indicators+="%F{#50fa7b}+%f"
        fi

        # UNSTAGED or UNTRACKED (*): Dracula Red (#ff5555)
        # Matches any change in second column OR new files (??)
        if echo "$git_status" | grep -qE "^.[MADRC]|^\?\?"; then
            indicators+="%F{#ff5555}*%f"
        fi

        # Returns: [branch]+* (with Cyan branch name #8be9fd)
        echo " %F{#8be9fd}[${branch}]%f${indicators}"
    fi
}

# Dracula Palette: Purple (#bd93f9) for dir, White (#f8f8f2) for $
# PROMPT BREAKDOWN:
# [%*]       -> [HH:MM:SS] in Dracula Comment (Grey/Purple)
# %1~        -> Current directory name only in Dracula Purple
# $(...)     -> Your Git function
# $          -> Literal dollar sign in Dracula White
PROMPT='%F{#6272a4}[%*]%f %F{#bd93f9}%1~%f$(parse_git_branch) %F{#f8f8f2}$%f '


# Shell integrations
eval "$(fzf --zsh)"
if [[ -o interactive ]]; then
  eval "$(zoxide init --cmd cd zsh)"
fi

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

alias fman="compgen -c | fzf | xargs man"
