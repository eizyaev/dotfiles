alias cdgit='cd  /cygdrive/c/Users/user/Documents/GitHub'
alias hafala2='cd  /cygdrive/c/hafala/shared/Afala_1'


alias vi='/usr/bin/vim'

# hopefully oneday have my ultimate .vimrc file
alias badvim='ln -sf .vim_runtime/.vimrc'
alias myvim='ln -sf dotfiles/.vimrc'

lightc()
{
	ln -sf dotfiles/mintty/.dir_colors_light ~/.dir_colors
	ln -sf dotfiles/mintty/.minttyrc_light ~/.minttyrc
}

darkc()
{
	ln -sf dotfiles/mintty/.dir_colors_dark ~/.dir_colors
	ln -sf dotfiles/mintty/.minttyrc_dark ~/.minttyrc
}

eval `dircolors ~/.dir_colors`
alias ls="ls --color"
