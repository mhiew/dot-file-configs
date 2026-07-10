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
# reloads zshrc across all tmux panes running zsh (skips claude, vim, etc.)
alias mshellall='tmux list-panes -a -F "#{pane_current_command} #{session_name}:#{window_index}.#{pane_index}" | grep "^zsh " | cut -d" " -f2 | xargs -I PANE tmux send-keys -t PANE "source ~/.zshrc" Enter'

#use vim keybindings for shell commands
#set -o vi

# always use ls with color
alias ls='ls --color'

alias c='clear; tmux clear-history'

# Run any command, monitor it, and copy output ONLY on failure
function copyFail() {
  local tmpfile=$(mktemp)
  # Run the command, redirecting stderr to stdout, then tee to temp file
  "$@" 2>&1 | tee "$tmpfile"
  
  # Check if the command (the first part of the pipe) failed
  if [[ ${pipestatus[1]} -ne 0 ]]; then
    cat "$tmpfile" | pbcopy
    echo "\n[!] Command failed. Output copied to clipboard."
  fi
  rm "$tmpfile"
}

# git helpers (requires fzf)
#fuzzy search over branches
alias fsb='${DIR}/scripts/fsb.sh'
#fuzzy search over commits
alias fsc='${DIR}/scripts/fsc.sh'
#fuzzy search over tmux sessions - attach, kill, or create new
alias fts='${DIR}/scripts/fts.sh'

# interactively unstage files (multi-select with Tab)
unstage() {
  local root=$(git rev-parse --show-toplevel)
  local files=$(git diff --cached --name-only | fzf-tmux -p 90%,80% --reverse -m --ansi \
    --border-label " unstage files " --border-label-pos 3 \
    --header "tab: select | enter: unstage | q: abort
ctrl-d/ctrl-u: scroll preview" \
    --bind "q:abort,ctrl-d:preview-page-down,ctrl-u:preview-page-up" \
    --preview "cd $root && git diff --cached --color=always -- {}" \
    --preview-window=right:60%)
  [[ -n "$files" ]] && echo "$files" | while read -r f; do
    if git cat-file -e HEAD:"$f" 2>/dev/null; then
      git -C "$root" reset HEAD -- "$f"
    else
      git -C "$root" rm --cached -- "$f"
    fi
  done
}

function gitamend {
    if [ -z "$1" ]; then
        git commit --amend --no-edit;
    else
        git commit --amend -m "$@";
    fi;
}
# open editor to amend full commit message (subject + body)
alias gitamend-edit="git commit --amend"
# reset working tree to last commit (tracked + untracked)
git-clear() {
  echo "This will discard ALL changes (tracked and untracked). Continue? [y/N]"
  read -r response
  [[ "$response" =~ ^[Yy]$ ]] && git reset --hard HEAD && git clean -fd
}
alias lg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --simplify-by-decoration"
alias lg1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --simplify-by-decoration"

# Rebase current branch onto a target branch without checking it out.
# Avoids two slow checkouts by using git fetch to update the local ref directly.
# Usage: rebase-onto <branch>
rebase-onto() {
  git fetch origin "$1":"$1" && git rebase -i "$1"
}
rebase-gm() { rebase-onto green-master; }
# update local master and green-master refs
# pulls the current branch if on master/green-master, fetches the rest
git_sync_masters() {
  local current=$(git rev-parse --abbrev-ref HEAD)
  local -a branches=()
  for b in master green-master; do
    if [[ "$current" == "$b" ]]; then
      git pull
    else
      branches+=("$b:$b")
    fi
  done
  (( ${#branches} )) && git fetch origin "${branches[@]}"
}
alias git-sync-masters="git_sync_masters"

# faster git status but does not view untracked files
alias gitfstatus="git status -uno"

# ability to see git trace information
alias gittrace="GIT_TRACE=1 GIT_TRACE_PERFORMANCE=1 GIT_LFS_FORCE_PROGRESS=1"

### Shell Prompt Configuration
# Enable function execution inside the prompt
setopt PROMPT_SUBST

parse_git_branch() {
    # Get current branch name
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    if [[ -n "$branch" ]]; then
        local indicators=""

        # NOTE: We avoid `git status --porcelain` here because it does a full
        # working tree scan (including recursive untracked file enumeration).
        # In large repos like android-register (25k+ LFS files), that adds
        # noticeable delay to every prompt render. Instead we use targeted
        # git commands that each do the minimum work needed.

        # STAGED (+): Dracula Green (#50fa7b)
        # git diff --cached --quiet only checks the index, no working tree scan
        if ! git diff --cached --quiet 2>/dev/null; then
            indicators+="%F{#50fa7b}+%f"
        fi

        # UNSTAGED (*): Dracula Red (#ff5555)
        # git diff --quiet only checks tracked files (no untracked scan)
        # Untracked file detection is omitted — any command that enumerates
        # untracked files (git status, git ls-files --others) is too slow
        # in large repos like android-register (25k+ files)
        if ! git diff --quiet 2>/dev/null; then
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
