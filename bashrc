# For ls command colors to work with Solarized color scheme
eval `dircolors ~/.dir_colors`
# Add current directory to the PATH variable
export PATH=.:$PATH
export PATH=/cygdrive/c/Users/user/Anaconda3/:$PATH
export PATH=/cygdrive/c/Program\ Files/erl8.1/bin/:$PATH

# Useful shortcuts
alias ls="ls --color"
alias ll="ls -l"
alias l="less"
alias ..="cd .."
alias ...="cd ~"
alias reload="source ~/.bashrc"
alias t2="ssh eiv@t2.technion.ac.il"

# Tools shortcuts
alias vi='/usr/bin/vim'
alias werl='/cygdrive/c/"Program Files"/erl8.1/bin/werl.exe'
alias erl='/cygdrive/c/"Program Files"/erl8.1/bin/erl.exe'

# Consider deleting
alias desktop="cd C:/Users/user/Desktop"
alias vmware="cd /cygdrive/c/hafala/shared"
alias open="cygstart"
alias updot="git submodule update --init --recursive"
alias cdgit='cd  /cygdrive/c/Users/user/Documents/GitHub'
alias hafala2='cd  /cygdrive/c/hafala/shared/Afala_1'

# enables to scroll completes with tab
bind '"\t":menu-complete'

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

# Solarized colorscheme toggle
lightc()
{
  ln -sf ~/.dotfiles/mintty/dir_colors_light ~/.dir_colors
  ln -sf ~/.dotfiles/mintty/minttyrc_light ~/.minttyrc
}

darkc()
{
  ln -sf ~/.dotfiles/mintty/dir_colors_dark ~/.dir_colors
  ln -sf ~/.dotfiles/mintty/minttyrc_dark ~/.minttyrc
}
