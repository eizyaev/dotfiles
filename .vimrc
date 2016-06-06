echo ">^.^<"

" enables number
set number
" numbers offset from leftside
set numberwidth=1
" open many files when some of them are unsaved
set hidden
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" show status line
set laststatus=2
set statusline=%f         " Path to the file
set statusline+=/         " Separator
set statusline+=%{fugitive#statusline()}
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Pathogen                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required
source ~/dotfiles/vim/bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect('~/dotfiles/vim/bundle/{}')
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            normal/visual mode mappings                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
let maplocalleader = "\\"

" noremap = Nonrecursive Mapping
noremap <leader>- ddp
noremap <leader>o 2ddp
noremap <leader>_ ddkkp
" move to beggining of line
noremap H 0
" move to end of line
noremap L $
" double quot current word
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" single quot current word
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
" ev = edit my vimrc file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" sv = source my vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            insert mode mappings:                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: disable the added space 
inoremap <c-u> <esc>viwUi 
" easy exit from insert mode
inoremap jk <esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            visual mode mappings:                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" single quot visual selection
vnoremap <leader>' <esc>a'<esc>`<i'<esc>`>el
" double quot visual selection
vnoremap <leader>" <esc>a"<esc>`<i"<esc>`>el

" My signature
iabbrev ssig -- <cr>Eiv Izyaev<cr>eivizyaev@gmail.com

" Muscle memory training
"inoremap <esc> <nop> " Ruins Arrow keys in insert mode
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>

syntax enable
set hlsearch
set background=dark
let g:solarized_termtrans=1
colorscheme solarized
call togglebg#map("<F5>")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            NERDTree configurations                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open NERDTree when no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Map NERDtree to <C-n>
map <C-n> :NERDTreeToggle<CR>
" Close window if the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
set encoding=utf-8
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'
