alias cdgit='cd  /cygdrive/c/Users/user/Documents/GitHub'
alias hafala2='cd  /cygdrive/c/hafala/shared/Afala_1'

alias vi='/usr/bin/vim'

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

# For ls command colors
eval `dircolors ~/.dir_colors`

alias ls="ls --color"
alias desktop="cd C:/Users/user/Desktop"
alias open="cygstart"
alias reload="source ~/.bashrc"
alias t2="ssh eiv@t2.technion.ac.il"
alias updot="git submodule update --init --recursive"

# Opens the github page for the current git repository in your browser
# git@github.com:jasonneylon/dotfiles.git
# https://github.com/jasonneylon/dotfiles/
function gh() {
  giturl=$(git config --get remote.origin.url)
  if [ "$giturl" == "" ]
    then
     echo "Not a git repository or no remote.origin.url set"
     exit 1;
  fi
 
  giturl=${giturl/git\@github\.com\:/https://github.com/}
  open $giturl
}
