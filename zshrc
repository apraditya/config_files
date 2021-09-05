# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="candy"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow git-extras gitfast rails ruby dirpersist z rbenv node npm aws bgnotify safe-paste bundler tmux emoji fzf yarn docker docker-compose zsh-completions zsh-syntax-highlighting colored-man-pages vi-mode dotenv)

FZF_BASE=$(which fzf)
ZSH_DOTENV_PROMPT=false

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# use vim as an editor
export EDITOR=vim

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
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

export PATH=/usr/local/sbin:/usr/local/bin:$HOME/.yarn/bin:$HOME/bin:$PATH
export GOPATH=/usr/local/opt/go/libexec/bin
if [ -e "/usr/libexec/java_home" ]; then
  export JAVA_HOME=`/usr/libexec/java_home`
fi


# Fast Node Manager (fnm)
export PATH=$HOME/.fnm:$PATH
eval "$(fnm env)"

# Fix Ctrl + H does not work
# https://github.com/neovim/neovim/issues/2048
export TERMINFO="$HOME/.terminfo"

export NVIM_PYTHON_LOG_FILE=/tmp/log
export NVIM_PYTHON_LOG_LEVEL=DEBUG
