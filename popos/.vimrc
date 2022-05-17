filetype on

" PLUG
" directory for plugins
" - avoid using standard vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" plugins
" code
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'

" theme
Plug 'sheerun/vim-polyglot'
Plug 'haishanh/night-owl.vim'
Plug 'nathanaelkane/vim-indent-guides'

" git
Plug 'tpope/vim-fugitive'

" buffer and status line
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" initialize plugin system
call plug#end()

" EDITOR
" set <space> as leader key
nnoremap <SPACE> <Nop>
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

" remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" THEME
set showmatch " show matching parenthesis
syntax enable
colorscheme night-owl

" enable 24 bit true color
if (has("termguicolors"))
 set termguicolors
endif

" enable comment highlighting in jsonc
autocmd FileType json syntax match Comment +\/\/.\+$+

" SEARCH
set ignorecase " ignore case when searching
set smartcase " except when contains uppercase

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

" navigate in split without <c-w>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" <leader> + bq to close current buffer and move to the previous one
nnoremap <leader>bq :bp <BAR> bd #<CR>

" <leader> + w to save/write
nnoremap <leader>w :w<CR>

" VIM CLOSETAG
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1

" VIM INDENT GUIDES
let g:indent_guides_enable_on_vim_startup=1

" LIGHTLINE
set laststatus=2 " show mode and file
set noshowmode " disable default show mode

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

" TAB/BUFFER LINE
set showtabline=2 " show tabline

let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}

let g:lightline#bufferline#show_number=2 " add ordinal number
let g:lightline#bufferline#unnamed = '[No Name]' " set default name

" bufferline keybindings
" <leader> + ordinal number to goto buffer
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

" <leader> + d + ordinal number to delete buffer
nmap <Leader>d1 <Plug>lightline#bufferline#delete(1)
nmap <Leader>d2 <Plug>lightline#bufferline#delete(2)
nmap <Leader>d3 <Plug>lightline#bufferline#delete(3)
nmap <Leader>d4 <Plug>lightline#bufferline#delete(4)
nmap <Leader>d5 <Plug>lightline#bufferline#delete(5)
nmap <Leader>d6 <Plug>lightline#bufferline#delete(6)
nmap <Leader>d7 <Plug>lightline#bufferline#delete(7)
nmap <Leader>d8 <Plug>lightline#bufferline#delete(8)
nmap <Leader>d9 <Plug>lightline#bufferline#delete(9)
nmap <Leader>d0 <Plug>lightline#bufferline#delete(10)

" FZF
" <ctrl> + p to open GFiles
nnoremap <c-p> :GFiles<CR>

" COC
set updatetime=300 " speed things for ux
set shortmess+=c " don't pass messages to |ins-completion-menu|

" merge signcolumn and number column into one
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use <control> + c then r to trigger completion
inoremap <silent><expr> <c-c>r coc#refresh()

" make <CR> auto-select the first completion item and notify coc.nvim to format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" use `g[` and `g]` to navigate diagnostics
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" goTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" applying codeAction to the selected region.
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" remap keys for applying codeAction to the current buffer
nmap <leader>ac  <Plug>(coc-codeaction)
" apply AutoFix to problem on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')

" add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" coc-css
" enable @ keyword in scss files
autocmd FileType scss setl iskeyword+=@-@

" coc-explorer
" <leader> + n to open explorer
nmap <leader>n :CocCommand explorer<CR>
