export ANDROID_HOME=/Users/minhiew/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
alias gandroid="cd /Users/minhiew/Developer/greengage-mobile-android"
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#ls colors
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

#rbenv
eval "$(rbenv init -)"

#mysql56
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
