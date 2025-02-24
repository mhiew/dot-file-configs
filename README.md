# Configurations for Daily Tools
A place to drop some tools preferences and configurations for ease of sharing between devices.

# Setup

## Dependencies
- install homebrew
- brew install fzf
- brew install zoxide
- brew install tmux
- brew install tpm
- brew install bat

## initial setup
- source the `.zshrc` ie. `source $HOME/Developer/Program-Tool-Configurations/.zshrc`
- source the `.vimrc` ie. `source /Users/minhiew/Developer/Program-Tool-Configurations/.vimrc`. 
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
- TODO

## NerdFont
- brew tap homebrew/cask
- brew install --cask font-jetbrains-mono-nerd-font
- update iterm2 Settings > Profile > Text > Font

## iterm2
- TODO

## Git 
- use `git config --global --add --bool rebase.updateRefs true` [reference](https://andrewlock.net/working-with-stacked-branches-in-git-is-easier-with-update-refs/)

## .zsrhc  Warnings
`.zshrc` `vi` bindings seem to cause an lot of issues so I am going to avoid using it.
In particular whenever we hit escape to go into vi mode we have troubles exiting it and certain words in the cli are not editable.
So do not use:
```
set -o vi
```
