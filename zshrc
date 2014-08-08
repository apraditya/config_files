if [ -e ~/.profile ]
then source ~/.profile
fi

# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v

# use incremental search
bindkey ^R history-incremental-search-backward

# expand functions in the prompt
setopt prompt_subst

# prompt
#export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '
PROMPT="$(print '%{\e[1;31m%}%m>%{\e[0m%}') "
RPROMPT="$(print '%{\e[1;36m%}%40<...<%~ %{\e[2;33m%}<%*>%{\e[0m%}')"

# ignore duplicate history entries
setopt histignoredups

# keep more history
export HISTSIZE=30000
export SAVEHIST=30000
export HISTFILE=~/.hist_zsh
# History awesomeness!  see rant at dotfiles.org/~brendano/.inputrc
# (zsh does not use gnu readline, so doesnt use .inputrc, 
# but this duplicates those features...)
setopt inc_append_history
setopt hist_verify
setopt share_history
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_expire_dups_first


# More options (picked from these resources)
# http://anyall.org/.zshrc
# http://wiki.archlinux.org/index.php/Zsh
setopt autopushd pushdminus pushdtohome pushdignoredups
setopt cdablevars
setopt interactivecomments
setopt nobanghist
setopt nohup
setopt SH_WORD_SPLIT


# Vars used later on by Zsh
LS_COLORS='no=00;32:fi=00:di=00;34:ln=01;36:pi=04;33:so=01;35:bd=33;04:cd=33;04:or=31;01:ex=00;32:*.rtf=00;33:*.txt=00;33:*.html=00;33:*.doc=00;33:*.pdf=00;33:*.ps=00;33:*.sit=00;31:*.hqx=00;31:*.bin=00;31:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.deb=00;31:*.dmg=00;36:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.mpg=00;37:*.avi=00;37:*.gl=00;37:*.dl=00;37:*.mov=00;37:*.mp3=00;35:'
export LS_COLORS;


# allow approximate (tab completion)
zmodload -i zsh/complist   # completion for MANY commands
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd


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



# grep options
export GREP_OPTIONS='--color=auto'

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

# RVM Installation
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# NVM Installation
export NVM_DIR="/Users/apraditya/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#autojump
#Copyright Joel Schaerer 2008, 2009
#This file is part of autojump

#autojump is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#autojump is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with autojump.  If not, see <http://www.gnu.org/licenses/>.

#local data_dir=${XDG_DATA_HOME:-$([ -e ~/.local/share ] && echo ~/.local/share || echo ~)}
local data_dir=$([ -e ~/.local/share ] && echo ~/.local/share || echo ~)
if [[ "$data_dir" = "${HOME}" ]]
then
    export AUTOJUMP_DATA_DIR=${data_dir}
else
    export AUTOJUMP_DATA_DIR=${data_dir}/autojump
fi
if [ ! -e "${AUTOJUMP_DATA_DIR}" ]
then
    mkdir "${AUTOJUMP_DATA_DIR}"
    mv ~/.autojump_py "${AUTOJUMP_DATA_DIR}/autojump_py" 2>>/dev/null #migration
    mv ~/.autojump_py.bak "${AUTOJUMP_DATA_DIR}/autojump_py.bak" 2>>/dev/null
    mv ~/.autojump_errors "${AUTOJUMP_DATA_DIR}/autojump_errors" 2>>/dev/null
fi

function autojump_preexec() {
    { (autojump -a "$(pwd -P)"&)>/dev/null 2>>|${AUTOJUMP_DATA_DIR}/autojump_errors ; } 2>/dev/null
}

typeset -ga preexec_functions
preexec_functions+=autojump_preexec

alias jumpstat="autojump --stat"

function j { local new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";else false; fi }
