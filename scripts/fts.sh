#!/bin/bash

# Fuzzy search tmux sessions to attach to or kill
# Enter attaches/switches to the selected session (or creates a new one)
# Ctrl-x kills the selected session without leaving the picker
function fts() {
  local sessions selection name target
  local list_fmt='#{session_name}: #{session_windows} windows#{?session_attached, (attached),}'

  sessions=$(tmux list-sessions -F "$list_fmt" 2>/dev/null)

  if [ -z "$sessions" ]; then
    tmux new-session
    return
  fi

  selection=$(printf '%s\n[+] New session\n' "$sessions" | fzf-tmux -p --reverse -1 -0 \
    --border-label " tmux sessions " --border-label-pos 3 \
    --header "enter: attach/create | ctrl-x: kill session | ctrl-d/u: preview scroll" \
    --preview 'tmux list-windows -t "$(echo {} | cut -d: -f1)" 2>/dev/null' \
    --preview-window=right:50% \
    --bind "ctrl-d:preview-page-down" \
    --bind "ctrl-u:preview-page-up" \
    --bind "ctrl-x:execute[tmux kill-session -t \"\$(echo {} | cut -d: -f1)\"]+reload[tmux list-sessions -F \"$list_fmt\" 2>/dev/null]")

  [ -z "$selection" ] && return

  if [ "$selection" = "[+] New session" ]; then
    read "name?New session name (blank for default): "
    if [ -n "$name" ]; then
      target=$(tmux new-session -d -s "$name" -P -F '#{session_name}')
    else
      target=$(tmux new-session -d -P -F '#{session_name}')
    fi
  else
    target=$(echo "$selection" | cut -d: -f1)
  fi

  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$target"
  else
    tmux attach-session -t "$target"
  fi
}
fts "$@"
