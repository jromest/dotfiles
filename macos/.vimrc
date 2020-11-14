filetype on

" PLUG
" directory for plugins
" - avoid using standard vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" plugins
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dense-analysis/ale'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'alvan/vim-closetag'
Plug 'valloric/youcompleteme'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-fugitive'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'haishanh/night-owl.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" initialize plugin system
call plug#end()

" EDITOR
" set <space> as leader key
let mapleader = ' '

" backup/swap files
set backupdir=~/.vim/tmp/ " need to manually create the directories
set directory=~/.vim/tmp/

" speed things up
set hidden
set history=100
set autoread " autoload files if they change

set nowrap

" indenting logic
filetype plugin indent on
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent

" relative line number
set number relativenumber

" column ruler
set colorcolumn=80

" set backspace normally
set backspace=indent,eol,start

" remove whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" THEME
set showmatch " show matching parenthesis
syntax on
colorscheme night-owl

" enable italic in iterm vim
set t_ZH=[3m
set t_ZR=[23m

" set font
set guifont=Menlo\ for\ Powerline

" set term 24 bit color
if (has("termguicolors"))
 set termguicolors
endif

" SEARCH
set ignorecase " ignore case when searching
set smartcase  " except when contains uppercase

" highlight search keywords
set hlsearch
set incsearch

" <leader> + / to clear search highlights
nnoremap <silent> <leader>/ :nohlsearch<CR>

" KEYBINDINGS
" <leader> + r to reload vimrc
noremap <leader>r :source ~/.vimrc<CR>

" use arrow keys
noremap <D-A-RIGHT> <C-w>l
noremap <D-A-LEFT> <C-w>h
noremap <D-A-DOWN> <C-w><C-w>
noremap <D-A-UP> <C-w>W

" <leader> + bq to close the current buffer and move to the previous one
nnoremap <leader>bq :bp <BAR> bd #<CR>

" <leader> + w to save/write
nnoremap <leader>w :w<CR>

" VIM INDENT GUIDES
let g:indent_guides_enable_on_vim_startup = 1 " enable indentguides

" LIGHTLINE
set laststatus=2 " show mode and file
set noshowmode   " disable default show mode

let g:lightline = {
  \ 'colorscheme': 'nightowl',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ }

set showtabline=2 " show tabline
set guioptions-=e " display ligthline tabline

" hide path and show only filename
let g:lightline#bufferline#filename_modifier = ':t'

let g:lightline#bufferline#show_number=2 " add ordinal number
let g:lightline#bufferline#unnamed = '[No Name]' " set default name

" bufferline keybindings
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" NERDTREE
let NERDTreeMapActivateNode='<right>' " use right arrow to open a node
let NERDTreeShowHidden=1 " display hidden files

" <leader> + n to toogle nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>

" <leader> + j to locate focused file
nnoremap <leader>j :NERDTreeFind<CR>

" FZF
" <ctrl> + p to open GFiles
nnoremap <c-p> :GFiles<CR>

" YCM
" start autocompletion after 4 chars
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0

" don't show ycm preview window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" VIM CLOSETAG
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1

" ALE
" fixers and linter for javascript
let g:ale_fixers = {
  \ '*': ['trim_whitespace'],
  \ 'javascript': ['eslint'],
  \ }

let g:ale_linters = {
  \ 'javascript': ['eslint']
  \ }

" format on save
let g:ale_fix_on_save = 1
let g:ale_set_highlights = 0

" PRETTIER
" format on save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
