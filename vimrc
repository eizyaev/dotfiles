"=============================================================================
" My awesome vimrc file!
"=============================================================================
let mapleader = ","
let maplocalleader = "\\"
"=============================================================================
" Pathogen
"=============================================================================

set nocompatible              " be iMproved, required
filetype off                  " required
source ~/.dotfiles/vim/bundle/pathogen/autoload/pathogen.vim
call pathogen#infect('~/.dotfiles/vim/bundle/{}')
call pathogen#helptags()
filetype plugin indent on    " required

"=============================================================================
" My autocmd's
"=============================================================================

" Only do this part when compiled with support for auto commands
if has("autocmd")
  " Enable file type detection
  filetype on
  augroup my_autocmds
    autocmd!
    " autocmd to update syntax for each colorscheme change
    autocmd ColorScheme * source ~/.dotfiles/mark.vim
    " Open NERDTree when no files specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree
      \ | endif
    autocmd VimEnter * SyntasticToggleMode
    " Close window if the only window left is NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
      \ b:NERDTree.isTabTree()) | q | endif
    " Syntax of for vim files
    autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType sh setlocal ts=2 sts=2 sw=2 expandtab
    "autocmd InsertEnter * :set number | :set norelativenumber
    "autocmd InsertLeave * :set number | :set relativenumber
  augroup END
endif

"=============================================================================
" Vim color theme Solarized
"=============================================================================

set t_Co=256
syntax enable
set background=dark
let g:solarized_termtrans=1
call togglebg#map("<F5>")
"colorscheme solarized
colorscheme xoria256

"=============================================================================
" fugitive
"=============================================================================

" define Browse command so :Gbrowse work correctly
command! -bar -nargs=1 Browse silent! exe '!cygstart' shellescape(<q-args>, 1)
set foldlevel=10 " no folding, easier use of Gedit command

" special mapping to go the parent tree from tree/blob only
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

"=============================================================================
" Vim-airline
"=============================================================================

let g:airline_theme="solarized"
set laststatus=2 "fix vim-airline doesn't appear

"=============================================================================
" NERDTree configurations
"=============================================================================

" Map NERDtree to <C-n>
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'

"=============================================================================
" Syntastic
"=============================================================================

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = 'clang++' "cpp compiler
let g:syntastic_cpp_compiler_options = ' -std=c++14' "support 'c++11' standart

nnoremap <C-x> :call SyntasticToggleMode()<CR>

"=============================================================================
" Tabular
"=============================================================================

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|'
      \ && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),
      \ 'ce',line('.'))
  endif
endfunction

"=============================================================================
" General settings:
"=============================================================================

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

if !exists("g:my_tabs")
  " completing full tab for tabstop length
  set tabstop=4
  " when indenting with '>', use 4 spaces width
  set shiftwidth=4
  " the amount of spaces to insert/delete for each tab key
  set softtabstop=4
  " don't expand tabs into spaces
  set expandtab
  let g:my_tabs=1
endif

" Preserve function saves cursor state and executes the command
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
" Clean trailing white spaces
nnoremap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" Indent all file
nnoremap _= :call Preserve("normal gg=G")<CR>

set wrap " splits long numbered line into a few displayed lines
set linebreak " doesn't break in the middle of word
set showbreak=… " if a line is broken adds '…' at start of the ling
set ignorecase " case insensitive search
" when searching with uppercase char do case sensitive search
set smartcase
set textwidth=80 "break lines at 80
set colorcolumn=+1 "add line at 80 to see the margin

" Show syntax highlighting groups for word under cursor
nnoremap <C-C> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" show the line numbers
set number
"set relativenumber

function! NumberToggle()
  if(&relativenumber == 1)
    set number
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunc

nnoremap <C-m> :call NumberToggle()<cr>

set numberwidth=1 " numbers offset from left side

" open many files when some of them are unsaved
set hidden

set showcmd " show command in bottom bar

"set cursorline " highlight current line

set wildmenu " visual auto complete for command menu

set incsearch " search as characters are entered
set hlsearch " highlight matches

" white space symbols when list enabled
set listchars=eol:¬,tab:•-,trail:~,extends:>,precedes:<

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

"=============================================================================
" normal/visual mode mappings
"=============================================================================

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

" noremap = Non recursive Mapping
noremap <leader>- ddp
noremap <leader>o 2ddp
noremap <leader>_ ddkkp
" double quot current word
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" single quot current word
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" easy vimrc files update on the run
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev  :tabedit $MYVIMRC<CR>

" highlight last inserted text
nnoremap gV `[v`]

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>

" key bind for CtrlPTag extension
nnoremap <leader>. :CtrlPTag<cr>

" TagbarToggle
nmap <F8> :TagbarToggle<CR>

" Toggle spell checking on and off with
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_us "us English spell checking

" switching between windows easier
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"=============================================================================
" insert mode mappings:
"=============================================================================

" TODO: disable the added space
inoremap <c-u> <esc>viwUi
" easy exit from insert mode
inoremap jk <esc>

"=============================================================================
" visual mode mappings:
"=============================================================================

" single quot visual selection
vnoremap <leader>' <esc>a'<esc>`<i'<esc>`>el
" double quot visual selection
vnoremap <leader>" <esc>a"<esc>`<i"<esc>`>el
