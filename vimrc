"==========================================================
" My awesome vimrc file!
"==========================================================
echo ">^.^<"
"==========================================================
" Pathogen
"==========================================================

set nocompatible              " be iMproved, required
filetype off                  " required
source ~/.dotfiles/vim/bundle/pathogen/autoload/pathogen.vim
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

set t_Co=256
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
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'

"==========================================================
" General settings:
"==========================================================

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

nnoremap <C-A> :call SummarizeTabs()<CR>
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" when expandtab enabled, delete 4 space with backspace
set softtabstop=4
" don't expand tabs into spaces
set noexpandtab

" Preserve funcion saves cursor state and executes the command
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" Clean trailing whitespaces
nnoremap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" Ident all file
nnoremap _= :call Preserve("normal gg=G")<CR>

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on

  " Syntax of for vim files
  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
endif

set wrap " splits long numbered line into a few displayed lines
set linebreak " doesnt break in the middle of word

" Show syntax highlighting groups for word under cursor
nnoremap <C-C> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

set relativenumber " enables relative numbers

set numberwidth=1 " numbers offset from leftside

" open many files when some of them are unsaved
set hidden

set showcmd " show command in bottom bar

set cursorline " highlight current line

set wildmenu " visual autocomplete for command menu

set incsearch " search as characters are entered
set hlsearch " highlight matches

" white space symbols when list enabled
set listchars=eol:¬,tab:▸-,trail:~,extends:>,precedes:<
"Invisible character colors
highlight NonText guifg=#4a4a59 " = eol
highlight SpecialKey guifg=#a84630 " = tab

" make backspace work normally
set backspace=2

" disable bell
:set vb t_vb=

" show status line
set statusline=%f         " Path to the file
set statusline+=/         " Separator
set statusline+=%{fugitive#statusline()}
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

" for tags to search in current folder
set tags=./tags;/

"==========================================================
" normal/visual mode mappings
"==========================================================

let mapleader = ","
let maplocalleader = "\\"

" easy open files in the directory of current open file
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>eS :vsp %%
map <leader>et :tabe %%

" fold/unfold easily
nnoremap <Space> za

" Clear search highlighting
noremap <leader>h :nohlsearch<cr>

" noremap = Nonrecursive Mapping
noremap <leader>- ddp
noremap <leader>o 2ddp
noremap <leader>_ ddkkp
" double quot current word
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" single quot current word
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" easy vimrc files update on the run
nnoremap <leader>sv source $MYVIMRC<CR>
nnoremap <leader>v :tabedit $MYVIMRC<CR>

" highlight last inserted text
nnoremap gV `[v`]

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>

" key bind for CtrlPTag extension
nnoremap <leader>. :CtrlPTag<cr>

" TagbarToggle
nmap <F8> :TagbarToggle<CR>

" smooth half page scrolling
:nnoremap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>
:nnoremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>

" switching between windowses easier
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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
"nnoremap <Left> <nop>
"nnoremap <Right> <nop>
"nnoremap <Up> <nop>
"nnoremap <Down> <nop>
" don't expand tabs into spaces
set noexpandtab

set showcmd             " show command in bottom bar

set cursorline          " highlight current line

set wildmenu            " visual autocomplete for command menu

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" white space symbols when list enabled
set listchars=eol:¬,tab:▸-,trail:~,extends:>,precedes:<
"Invisible character colors
highlight NonText guifg=#4a4a59 " = eol
highlight SpecialKey guifg=#a84630 " = tab

" make backspace work normally
set backspace=2

" show status line
set statusline=%f         " Path to the file
set statusline+=/         " Separator
set statusline+=%{fugitive#statusline()}
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

" for tags to search in current folder
set tags=./tags;/

"==========================================================
" normal mode mappings
"==========================================================

let mapleader = ","
let maplocalleader = "\\"

" noremap = Nonrecursive Mapping
noremap <leader>- ddp
noremap <leader>o 2ddp
noremap <leader>_ ddkkp
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

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>

" key bind for CtrlPTag extension
nnoremap <leader>. :CtrlPTag<cr>

" TagbarToggle
nmap <F8> :TagbarToggle<CR>

" smooth half page scrolling
nnoremap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>
nnoremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>

"==========================================================
" insert mode mappings:
"==========================================================

" upercase current word 
inoremap <c-u> <esc>lviwUi

" easy exit from insert mode
inoremap jk <esc>

" My signature
iabbrev ssig -- <cr>Eiv Izyaev<cr>eivizyaev@gmail.com

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
"nnoremap <Left> <nop>
"nnoremap <Right> <nop>
"nnoremap <Up> <nop>
"nnoremap <Down> <nop>
