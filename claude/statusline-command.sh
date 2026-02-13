#!/bin/bash

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // empty')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

WHITE='\033[1;37m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
RESET='\033[0m'

output_parts=()

if [ -n "$cwd" ]; then
    display_cwd="${cwd/#$HOME/~}"
    output_parts+=("$(printf "${WHITE}%s${RESET}" "$display_cwd")")

    if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
        git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || echo "detached")

        unstaged=""
        if ! git -C "$cwd" diff --quiet 2>/dev/null || \
           [ -n "$(git -C "$cwd" ls-files --others --exclude-standard 2>/dev/null)" ]; then
            unstaged="*"
        fi

        staged=""
        if ! git -C "$cwd" diff --quiet --cached 2>/dev/null; then
            staged="+"
        fi

        output_parts+=("$(printf "${CYAN}%s%s%s${RESET}" "$git_branch" "$unstaged" "$staged")")
    fi
fi

if [ -n "$remaining" ]; then
    output_parts+=("$(printf "${YELLOW}%s%% remaining${RESET}" "$remaining")")
fi

first=true
for part in "${output_parts[@]}"; do
    if [ "$first" = true ]; then
        printf "%s" "$part"
        first=false
    else
        printf " | %s" "$part"
    fi
done
