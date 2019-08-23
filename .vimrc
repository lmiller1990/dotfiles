" ---------------------------------
" This is Lachlan Millers vimrc
" ---------------------------------
" I am using the following plugins:
" ---------------------------------
" - ctrlp for fuzzy file finding 
" - nerdtree for tree viewer
" - surround.vim 
" - emmet.vim
" - plus some lang. specifics
"
" I am using pathogen.vim to manage plugins.
" Install pathogen by running:
"
" mkdir -p ~/.vim/autoload ~/.vim/bundle &&  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"
" Now install the plugins using by running:
" cd ~/.vim/bundle && git clone git://github.com/tpope/vim-surround.git && git clone https://github.com/scrooloose/nerdtree.git && git clone && https://github.com/ctrlpvim/ctrlp.vim && git clone https://github.com/mattn/emmet-vim.git
"
" And you should be good to go!

" Map , to leader
let mapleader = ","

" relative line numbers
set number

" syntax highlighting
syntax on

" Make backspace behave normally
set backspace=indent,eol,start

" reduce escape sequence timeout length to 100ms
set ttimeoutlen=10

" indent settings
filetype plugin indent on
:set tabstop=2
:set shiftwidth=2
:set softtabstop=0 
:set expandtab 
:set shiftwidth=2 
:set smarttab

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move panes with space h/j/k/l
nnoremap <space> <C-w>
nnoremap <space>p :CtrlP<cr>

" better autocomplete with tab
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

" Quickly switch between two buffers using ,,
nnoremap <leader><leader> <C-^>

" tab and space-tab to move back and forth through tabs
nnoremap <tab> gt
noremap <space><tab> gT

" Use pathogen to install packages
execute pathogen#infect()

" ctrl-p ignore
let g:ctrlp_custom_ignore = "node_modules\|DS_Store\|git|resources|vendor"

" use silver searcher if available for extremely fast fuzzy searching
if executable("ag")
  let g:ctrlp_user_command = "ag %s -l --nocolor -g ''"
endif

" do not limit amount of files shown
let g:ctrlp_max_files=0

" forgot what this does...
set runtimepath^=~/.vim/bundle/ctrlp.vim

" open nerd tree with ctrl + n
map <C-n> :NERDTreeToggle<CR>

" .swp files are annoying
" put them somewhere out of the way
" copy pasted this, not really sure if it is all necessary
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nowritebackup

" rerun last terminal command using ,r
nnoremap <leader>r :!!<CR>

" match do/end in ruby
runtime macros/matchit.vim

" Colorscheme
set t_md=

" ush zsh
set shell=/usr/local/bin/zsh
