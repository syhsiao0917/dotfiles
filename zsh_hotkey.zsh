

## source 
alias somy="source ~/.zshrc"

## history 
setopt hist_ignore_space 
# alias cd=" cd" 
alias ls=" ls"


## control+s as ls 

stty -ixon ## disable control+s as suspend 

function _control_s { 
	buf=$BUFFER
	cur=$CURSOR

	BUFFER='ls ' 
	CURSOR=3
	zle list-choices

	BUFFER=$buf
	CURSOR=$cur

} 

zle -N _control_s
bindkey '^s'  _control_s

## get pwd 
function _get_pwd { 
	zle -U $(pwd) 
} 

## for alt+backspace on path 
export WORDCHARS='*?_[]~=&;!.#$%^(){}-'

# tip: alt+backspace to delete path 
# tip: ctrl+y to undo delete

zle -N _get_pwd
bindkey '^[d' _get_pwd

## directory up 
function _dir_up { 
   cd .. 
   zle reset-prompt 
}
zle -N _dir_up
bindkey '^[e' _dir_up

## 
function _mkdir_cd()  { 
	mkdir $1 
	cd $1
}

alias md='_mkdir_cd'

### insert argument  ref: http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html

bindkey '^r' insert-last-word
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^u" copy-earlier-word

# tip: first use control+r to insert last argument 
# tip: next control+r will insert previous command line last argument 
# tip: control+r will insert previous argument 


