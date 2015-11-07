" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Plugin 'gmarik/vundle'

" My Plugins
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-dispatch'
Plugin 'mattn/emmet-vim'
Plugin 'dsawardekar/ember.vim'
Plugin 'mhinz/vim-signify'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'thoughtbot/vim-rspec'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'slim-template/vim-slim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'rizzatti/dash.vim'
Plugin 'benmills/vimux'

filetype plugin indent on

" User Interface
""""""""""""""""""""

set modelines=0
set clipboard=unnamed
set synmaxcol=128
set encoding=utf-8
set ignorecase
set smartcase
set nolazyredraw " don't redraw while executing macros

set magic " Set magic on, for regex

syntax enable
set background=dark
colorscheme solarized
call togglebg#map("<F5>")

" Fix scrolling on iTerm2. Additionally, run this command:
" defaults write com.googlecode.iterm2 AlternateMouseScroll -bool true
set mouse=nicr

set autoread  " detect when a file is changed
set ttyfast   " faster redrawing

if !has('nvim')
  set ttyscroll=10
endif

" Automatic formatting
autocmd BufWritePre *.rb :%s/\s\+$//e
autocmd BufWritePre *.go :%s/\s\+$//e
autocmd BufWritePre *.haml :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.scss :%s/\s\+$//e
autocmd BufWritePre *.slim :%s/\s\+$//e

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set noswapfile
set nobackup
set nowritebackup
set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set nohlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" code folding settings
set foldnestmax=10 " deepest fold is 10 levels
set foldlevel=1
set nofoldenable " don't fold by default

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = "\\"

" Mappings for convenience
map <F2> :NERDTreeToggle<CR>
" Jumping to split views
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
map ,p "+gp

" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

" Leader shortcuts for Rails commands (vim-rails)
map <Leader>m :Emodel
map <Leader>c :Econtroller
map <Leader>v :Eview
map <Leader>u :Eunittest
map <Leader>f :Efunctionaltest
map <Leader>i :Eintegrationtest
map <Leader>h :Ehelper
map <Leader>tm :ETmodel
map <Leader>tc :ETcontroller
map <Leader>tv :ETview
map <Leader>tu :ETunittest
map <Leader>tf :ETfunctionaltest
map <Leader>sm :ESmodel
map <Leader>sc :EScontroller
map <Leader>sv :ESview
map <Leader>su :ESunittest
map <Leader>sf :ESfunctionaltest
map <Leader>si :ESintegrationtest

" vim-rspec mappings
map <Leader>st :call RunCurrentSpecFile()<CR>
map <Leader>ss :call RunNearestSpec()<CR>
map <Leader>sl :call RunLastSpec()<CR>
map <Leader>sa :call RunAllSpecs()<CR>

let g:rspec_command = "compiler rspec | set makeprg=zeus | Make rspec {spec}"
let g:rspec_runner = "os_x_iterm2"

" Hide search highlighting
map <Leader>l :set invhls <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Prevents YouCompleteMe using Tab to use side-by-side with ultisnips
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Edit routes
command! Rroutes :e config/routes.rb
command! RTroutes :tabe config/routes.rb

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Color scheme
" colorscheme vividchalk
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set relativenumber
set numberwidth=5

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,t

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Window navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>

" Added this to support scss highlight
" from tpope: http://github.com/tpope/vim-haml/issues#issue/7/comment/254442
autocmd BufNewFile,BufRead *.scss set filetype=css

" Emmet setting
let g:user_emmet_install_global = 0
autocmd FileType html,css,erb EmmetInstall

