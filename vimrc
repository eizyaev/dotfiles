echo ">^.^<"

set relativenumber " enables relative numbers

set numberwidth=1 " numbers offset from leftside

" open many files when some of them are unsaved
set hidden

" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

set showcmd             " show command in bottom bar

set cursorline          " highlight current line

set wildmenu            " visual autocomplete for command menu

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" show status line
set statusline=%f         " Path to the file
set statusline+=/         " Separator
set statusline+=%{fugitive#statusline()}
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

"==========================================================
" Pathogen
"==========================================================

set nocompatible              " be iMproved, required
filetype off                  " required
source ~/.dotfiles/vim/bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect('~/.dotfiles/vim/bundle/{}')
call pathogen#helptags()
filetype plugin indent on    " required

"==========================================================
" Vim color theme Solarized
"==========================================================

syntax enable
set background=dark
let g:solarized_termtrans=1
colorscheme solarized
call togglebg#map("<F5>")

"==========================================================
" Vim-airline
"==========================================================

let g:airline_theme="solarized"
set laststatus=2 "fix vim-airline doesn't appear

"==========================================================
" NERDTree configurations
"==========================================================

" Open NERDTree when no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Map NERDtree to <C-n>
map <C-n> :NERDTreeToggle<CR>
" Close window if the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'


"==========================================================
" normal/visual mode mappings
"==========================================================

let mapleader = ","
let maplocalleader = "\\"

" Clear search highlighting
noremap <leader>h :nohlsearch<cr>

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

" highlight last inserted text
nnoremap gV `[v`]

"==========================================================
" insert mode mappings:
"==========================================================

" TODO: disable the added space
inoremap <c-u> <esc>viwUi
" easy exit from insert mode
inoremap jk <esc>

"==========================================================
" visual mode mappings:
"==========================================================

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

