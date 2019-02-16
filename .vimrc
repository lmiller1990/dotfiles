" ---------------------------------
" This is Lachlan Miller's vimrc
" ---------------------------------
" I am using the following plugins:
" ---------------------------------
" - ctrlp for fuzzy file finding 
" - nerdtree for tree viewer
" - surround.vim 
" - emmit.vim
" - ALE for language server (eg for TypeScript autocompletion)
"
" I am using pathogen.vim to manage plugins.
" Install pathogen by running:
"
" mkdir -p ~/.vim/autoload ~/.vim/bundle && \
" curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"
" Now install the plugins using by running:
" cd ~/.vim/bundle
"
" git clone git://github.com/tpope/vim-surround.git
" git clone https://github.com/scrooloose/nerdtree.git
" git clone https://github.com/ctrlpvim/ctrlp.vim
" git clone https://github.com/mattn/emmet-vim.git
" git clone https://github.com/w0rp/ale.git
"
" brew install ctags
" (in your repo) ctags -R .
"
" And you should be good to go!

""""""""""""""""""""""""""""""""
" Basic settings
""""""""""""""""""""""""""""""""
set number
syntax on
filetype plugin indent on
let mapleader = ','
" Make backspace behave normally
set backspace=indent,eol,start
" reduce escape sequence timeout length to 100ms
set ttimeoutlen=100

" indent settings
:set tabstop=2
:set shiftwidth=2
:set softtabstop=0 
:set expandtab 
:set shiftwidth=2 
:set smarttab

imap <c-J> <nop>
""""""""""""""""""""""""""""""""
" Movement within a file
""""""""""""""""""""""""""""""""
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line with B and E
nnoremap B ^
nnoremap E $

" set relative number as default
set relativenumber

" toggle between number and relativenumber
function! ToggleNumber()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc

" Autocomplete with Tab
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

" treat all numerals as decimal, forgot why I did  this
set nrformats=

" matching def/ends in ruby
runtime macros/matchit.vim

" Quickly switch betweeen two files using ,,
nnoremap <leader><leader> <C-^>

""""""""""""""""""
" Navigation to other files 
""""""""""""""""""

command! MakeTags !ctags -R .

""""""""""""""""""
" Tabs
""""""""""""""""""

" when opening a new tab, immediately show fuzzy finder
nnoremap tt :tabe<CR><bar>:CtrlP<CR>

" tab and space-tab to move through tabs quickly
nnoremap <tab> gt
noremap <space><tab> gT

""""""""""""""""""""""""""""""
" Plugins 
""""""""""""""""""""""""""""""

" Ale for autocompletion
" Enable completion where available.
" Including .vue files
" This setting must be set before ALE is loaded.
let g:ale_linter_aliases = {'vue': 'typescript'}
let g:ale_linters = {'vue': ['tsserver']}
" let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_completion_enabled = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_list_window_size = 5

" USe pathogen to install packages
execute pathogen#infect()


""" ctrlp settings
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|resources|vendor'

" not sure what this does
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" use silver searcher if available for extremely fast fuzzy searching
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" do not limit amount of files shown
let g:ctrlp_max_files=0

set runtimepath^=~/.vim/bundle/ctrlp.vim

""" Nerd Tree 
map <C-n> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""
" Colors and Theme
""""""""""""""""""""""""""""""
" https://github.com/joshdick/onedark.vim
colorscheme onedark

""""""""""""""""""""""""""""""
" Backup Files
""""""""""""""""""""""""""""""

" .swp files are annoying
" put them somewhere out of the way
" copy pasted this, not really sure if it is all necessary
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nowritebackup

""""""""""""""""""""""""""""""
" Panes
""""""""""""""""""""""""""""""

" Resize vertical pane to be 80 characters wide
function! Resize80Cols()
  vertical resize 80  
endfunction

" Move between splits with Ctrl+ [hjkl] and resize to 80 chars
nnoremap <C-J> <C-W><C-J>:call Resize80Cols()<CR>
nnoremap <C-K> <C-W><C-K>:call Resize80Cols()<CR>
nnoremap <C-L> <C-W><C-L>:call Resize80Cols()<CR>
nnoremap <C-H> <C-W><C-H>:call Resize80Cols()<CR>

""""""""""""""""""""""""""""""
" Rerun command line arg with ,r
""""""""""""""""""""""""""""""
nnoremap <leader>r :!!<CR>

""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""

" Use .js highlighting in .jsx
let g:jsx_ext_required = 0

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
