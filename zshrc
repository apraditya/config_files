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

