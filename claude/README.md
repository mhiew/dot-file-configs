# Claude Code CLI Configuration

Config files for Claude Code CLI, symlinked to `~/.claude/` via the setup script.

## Setup

```bash
./setup-symlinks.sh
```

This symlinks all files in this directory to `~/.claude/`, excluding `setup-symlinks.sh` and this README.

## Config Files

| File | Purpose |
|------|---------|
| `settings.json` | Global settings (model, permissions, status line config) |
| `keybindings.json` | Custom key bindings |
| `statusline-command.sh` | Custom status line script |
| `CLAUDE.md` | Global Claude instructions |

## Status Line

A custom status line that shows the current working directory, git branch info, and remaining context tokens.

**What it displays:**
- Current working directory in **white** (with `~` replacing `$HOME`)
- Git branch name in **cyan**
- `*` if there are unstaged changes, `+` if there are staged changes
- Remaining context window percentage in **yellow**

Example: `~/Development/llm-learnings` | `main*+` | `87% remaining`

### Configuration

The status line is enabled in `settings.json`:
```json
{
  "statusLine": {
    "type": "command",
    "command": "bash /Users/mhiew/.claude/statusline-command.sh"
  }
}
```

### Dependencies

- `jq` — for parsing JSON input from Claude Code
- `git` — for branch and status information

## Keybindings

Custom keybindings are defined in `keybindings.json`.

| Keybind | Action | Default | Notes |
|---------|--------|---------|-------|
| `shift+enter` | Newline | `shift+enter` | — |
| `ctrl+v` | Open external editor | `ctrl+g` | Swapped to match shell `ctrl+v` edit-command shortcut |
| `ctrl+g` | Paste image | `ctrl+v` | Moved here from `ctrl+v` to accommodate the editor swap |
