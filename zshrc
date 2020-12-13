# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="candy"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow github git-extras gitfast rails ruby dirpersist z rbenv node npm heroku aws bgnotify safe-paste bundler tmux emoji fzf yarn docker docker-compose zsh-completions zsh-syntax-highlighting colored-man-pages vi-mode iterm2 dotenv)

FZF_BASE=$(which fzf)
ZSH_DOTENV_PROMPT=false

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
if [ -e ~/.profile ]
then source ~/.profile
fi

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# History awesomeness!  see rant at dotfiles.org/~brendano/.inputrc
# (zsh does not use gnu readline, so doesnt use .inputrc, 
# but this duplicates those features...)
setopt hist_no_store
setopt hist_reduce_blanks


# More options (picked from these resources)
# http://anyall.org/.zshrc
# http://wiki.archlinux.org/index.php/Zsh
setopt interactivecomments
setopt nobanghist
setopt nohup
setopt SH_WORD_SPLIT


# Key bindings 
# http://anyall.org/.zshrc works best for me
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward
bindkey "\eOA" history-beginning-search-backward
bindkey "\eOB" history-beginning-search-forward

bindkey "\e[1~" beginning-of-line
bindkey "\e[2~" quoted-insert
bindkey "\e[3~" delete-char
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "\eOd" backward-word
bindkey "\eOc" forward-word 



## FUNCTIONS
fin() {
  find . -iname "*$1*"
}

# Find a number latest modified files
latest() {
  ls -t **/*(D.om[1,$1])
}

# Find a number of the biggest files under the current dir
biggest() {
  ls -Sh **/*(-OL[1,$1])
}

# Create a dir with a time attached to its name
nowdir() {
  mkdir $(date "+%y%m%d")-$1
}

# Find files containting particular word
findin() {
  find $2 -type f | xargs grep -i $1
}

export PATH=/usr/local/sbin:/usr/local/bin:$HOME/bin:$PATH
export GOPATH=/usr/local/opt/go/libexec/bin
export JAVA_HOME=`/usr/libexec/java_home`

# NVM Installation
export NVM_DIR="$HOME/.nvm"
if hash brew; then
  source $(brew --prefix nvm)/nvm.sh
else
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Fix Ctrl + H does not work
# https://github.com/neovim/neovim/issues/2048
export TERMINFO="$HOME/.terminfo"

export NVIM_PYTHON_LOG_FILE=/tmp/log
export NVIM_PYTHON_LOG_LEVEL=DEBUG