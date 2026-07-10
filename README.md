# Configurations for Daily Tools
A place to drop some tools preferences and configurations for ease of sharing between devices.

# Setup

# OSX Rebind Capslock to Control
- Settings > Keyboard > Keyboard Shortcuts > Modifier Keys 
- Caps Lock Key to Control

## iterm2
- install from https://iterm2.com/downloads.html
- import iterm-min-profile.json

## Add Homebrew Dependencies
- install homebrew
- brew install fzf
- brew install zoxide
- brew install tmux
- brew install tpm
- brew install bat
- brew install glow
- brew install lnav

## initial setup
- source the `.zshrc` ie. `source $HOME/Developer/Program-Tool-Configurations/.zshrc`
- source the `.vimrc` ie. `source $HOME/Developer/Program-Tool-Configurations/.vimrc`. 
    - note use absolute path for `.vimrc` otherwise `.ideavimrc` wont be able to locate it as it doesn't understand path expansion
    - run `:PlugInstall` to get all the plugins we need
- source the `.ideavimrc` ie. `source $HOME/Developer/Program-Tool-Configurations/.ideavimrc`

## tmux setup
- source the `.tmux.conf` ie. `source $HOME/Developer/Program-Tool-Configurations/.tmux.conf`
- launch `tmux`
- `<C-a> I` to install tpm plugins
- use `<C-a> u` to uninstall tpm plugins that are removed from `.tmux.conf`

## Setup Android Studios
- import one of the android studios settings
- plugins: 
    - IdeaVim which is sourced from our `~/ideavimrc`
    - RelativeLineNumbers which we can configure to show both relative and absolute line numbers at the same time [reference](https://stackoverflow.com/a/78374798)

## Better Touch Tool
- install and add license
- import Default.bttpreset

### Usage
- cmd + 

## NerdFont
- brew tap homebrew/cask
- brew install --cask font-jetbrains-mono-nerd-font
- update iterm2 Settings > Profile > Text > Font

## Lnav
- https://docs.lnav.org/en/v0.12.3/intro.html

## Git 
- use `git config --global --add --bool rebase.updateRefs true` [reference](https://andrewlock.net/working-with-stacked-branches-in-git-is-easier-with-update-refs/)
- use `git config --global core.fsmonitor true` [reference](https://git-scm.com/docs/git-fsmonitor--daemon) 

## Claude Code CLI
- Config files stored in `claude/`: `settings.json`, `keybindings.json`, `statusline-command.sh`, `CLAUDE.md`
- Run `./claude/setup-symlinks.sh` to symlink everything to `~/.claude/`

# Usage
Quick reference for shortcuts/aliases in each config, since they're easy to forget between machines.

## vimrc Usage
Leader key is `<Space>`.

| Shortcut | Action |
|---|---|
| `jk` / `jK` / `JK` / `Jk` | Escape insert mode |
| `<leader>ev` | Open `.vimrc` in a vertical split |
| `<leader>sv` | Source (reload) `.vimrc` |
| `<leader>/` | Clear search highlight |
| `<leader>g` | Preview current markdown file with `glow` |
| `<leader>d` (normal/visual) | Delete without clobbering the unnamed register |
| `<leader>p` (visual) | Paste without clobbering the unnamed register |
| `H` / `L` (or `<C-h>` / `<C-l>`) | Jump to start/end of line (normal + visual) |
| `U` | Redo (remapped from `<C-r>`) |
| `K` | Move up a line (doc-lookup disabled — too easy to fat-finger) |
| `<C-j>` / `<C-k>` | Scroll 15 lines down/up, recentered |
| `<C-u>` / `<C-d>` | Page up/down, recentered |
| `n` / `N` | Next/prev search result, recentered |
| `` ` `` / `'` | Swapped: `` ` `` jumps to mark's line, `'` jumps to mark's line+column |
| Arrow keys | Disabled in normal + insert mode (forces hjkl) |

Plugins: `vim-surround`, `vim-repeat`, `dracula` theme (via vim-plug — `:PlugInstall`).

## tmux Usage
Prefix is `<C-a>` (rebound from the tmux default `<C-b>`). Shortcuts below are custom unless noted as **(default)** — those are stock tmux bindings that still work since they were never rebound.

**Pane management**
| Shortcut | Action |
|---|---|
| `<C-a> \|` | Split pane vertically (new pane to the right), keeps cwd |
| `<C-a> -` | Split pane horizontally (new pane below), keeps cwd |
| `<C-a> "` / `<C-a> %` | **(default)** split horizontally/vertically — kept, just patched to preserve cwd |
| `<C-a> C-h/j/k/l` | Move between panes (vim-style) |
| `<C-a> ;` | **(default)** jump to last active pane |
| `<C-a> q` | Show pane numbers, stays on screen until you pick one (default `q` auto-hides quickly) |
| `<C-a> x` | **(default)** kill current pane (confirms first) |
| `<C-a> o` | **(default)** cycle to next pane |
| `<C-a> z` | **(default)** toggle zoom on current pane |
| `<C-a> b` (or default `!`) | Break current pane out into its own window |
| `<C-a> j` | Join a window (prompts for name/index) into current window as a vertical split |
| `<C-a> f` | Flip layout between horizontal/vertical |
| `<C-a> t` / `<C-a> T` | Set / clear a custom pane title |
| `<C-a> {` / `<C-a> }` | **(default)** swap current pane up/down |
| `<C-a> M-←/→/↑/↓` | **(default)** resize pane by 5 cells (repeatable) |

**Window management**
| Shortcut | Action |
|---|---|
| `<C-a> c` | New window in cwd |
| `<C-a> h` / `<C-a> l` | Previous / next window |
| `<C-a> k` | Last active window |
| `<C-a> ←` / `<C-a> →` | Move current window left/right (repeatable, no need to re-hit prefix) |
| `<C-a> 0-9` | **(default)** jump directly to window N |
| `<C-a> $` | **(default)** rename session |
| `<C-a> s` | **(default)** interactive session/window tree picker |
| `<C-a> d` | **(default)** detach client |
| `<C-a> &` | **(default)** kill window (confirms first) |

**Copy mode** (vi keys, `<C-a> [` to enter)
| Shortcut | Action |
|---|---|
| `v` | Begin selection |
| `y` | Copy selection to system clipboard (`pbcopy`) and exit copy mode |
| Mouse drag + release | Copy selection to clipboard |
| `<C-a> P` | Paste tmux buffer |

**Plugins (tpm)**
| Shortcut | Action |
|---|---|
| `<C-a> I` | Install plugins listed in `.tmux.conf` |
| `<C-a> u` | Uninstall plugins removed from `.tmux.conf` |
| `<C-a> r` | Reload `.tmux.conf` |

**tmux-resurrect / tmux-continuum**
Sessions auto-save every 5 minutes and auto-restore on tmux start (`@continuum-restore on`). `<C-a> C-s` / `<C-a> C-r` manually save/restore on demand, but you rarely need them given autosave.

## zshrc Usage
Legend: `<C-x>` = Ctrl+x, `<M-x>` = Alt/Option+x (aka "Meta" — this is fzf's default binding, not something set in `.zshrc`).

**fzf**
| Shortcut | Action |
|---|---|
| `<C-t>` | Fuzzy-find files (via `fd`) and insert path at cursor |
| `<C-r>` | Fuzzy-search command history; `<C-y>` copies the selected command to clipboard |
| `<M-c>` | Fuzzy-cd into a subdirectory (with `tree` preview) |
| `<C-v>` | Edit the current command line in `$EDITOR` |

**Git helpers**
| Alias/function | Action |
|---|---|
| `lg` / `lg1` | Pretty `git log` graph |
| `fsb` | Fuzzy-search branches |
| `fsc` | Fuzzy-search commits |
| `unstage` | Interactively unstage files (multi-select with Tab) |
| `gitamend [msg]` | Amend commit; no-edit if no message given |
| `gitamend-edit` | Amend commit, opening full editor |
| `git-clear` | **Destructive** — hard reset + clean, asks for confirmation |
| `rebase-onto <branch>` | Fetch + rebase current branch onto `<branch>` without checking it out |
| `rebase-gm` | Shortcut for `rebase-onto green-master` |
| `git_sync_masters` / `git-sync-masters` | Pull/fetch latest `master` and `green-master` |
| `gitfstatus` | Fast `git status` (skips untracked files) |
| `gittrace` | Prefix a command to run it with `GIT_TRACE*` env vars on |

**Other**
| Alias/function | Action |
|---|---|
| `mshell` | Reload `.zshrc` in current shell |
| `mshellall` | Reload `.zshrc` in every zsh pane across all tmux sessions |
| `copyFail <cmd>` | Run a command; copy its output to clipboard only if it fails |
| `c` | Clear screen + tmux scroll history |
| `gw` / `gwp` | `./gradlew` / `./gradlew -p` |
| `fman` | Fuzzy-search man pages |

## .zsrhc  Warnings
`.zshrc` `vi` bindings seem to cause an lot of issues so I am going to avoid using it.
In particular whenever we hit escape to go into vi mode we have troubles exiting it and certain words in the cli are not editable.
So do not use:
```
set -o vi
```


