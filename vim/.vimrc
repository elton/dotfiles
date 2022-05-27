set nocompatible              " be iMproved, required
filetype off                  " required

" Remap the ESC Key
inoremap jk <ESC>
" Change Your Leader Key default is `\`
let mapleader = " "

" Use UTF-8 as the default buffer encoding
set encoding=utf-8
set fileformat=unix

" Turn syntax highlighting on
syntax on
syntax enable

set number
" vim show relative numbers. Requires vim 7.4
set relativenumber
" make the document start scrolling 8 lines before my cursor reaches the bottom line.
set scrolloff=8
set signcolumn=yes

set cursorline
set textwidth=79

set showcmd
set noshowmode
set conceallevel=1

" Show nice info in ruler
set ruler
set laststatus=2

set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <CR> :noh<CR><CR>:<backspace>

set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
set expandtab

set nowrap
" set list
" set listchars=eol:.,tab:>-,trail:~,extends:>,precedes:<

" disables sounds, bells
set noerrorbells visualbell t_vb=
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set clipboard=unnamed

set mouse=a

" Default to Unix LF line endings
set ffs=unix,dos,mac

call plug#begin()
Plug 'Yggdroot/indentLine'
Plug 'morhetz/gruvbox'
"Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' "airline 的主题
Plug 'scrooloose/nerdcommenter'
Plug 'luochen1990/rainbow'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/tagbar'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
" All of your Plugins must be added before the following line
call plug#end()

filetype plugin indent on    " required

" vim-go: Enable goimports on save
let g:go_fmt_command = "goimports"

" vim-airline
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1

" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
" autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

set rtp+=/usr/local/opt/fzf

" 支持全色
set termguicolors
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE
let g:terminal_ansi_colors = [
    \ '#282828', '#cc241d', '#98971a', '#d79921',
    \ '#458588', '#b16286', '#689d6a', '#a89984',
    \ '#928374', '#fb4934', '#b8bb26', '#fabd2f',
    \ '#83a598', '#d3869b', '#8ec07c', '#ebdbb2',
\]

" vim-github-comment
let g:github_user = 'elton'

" +=============================== NERD Commenter ====================================+ "
"add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
au FileType python let g:NERDSpaceDelims = 0

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" +=============================== NERD Tree ====================================+ "
" Making it prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeRespectWildIgnore=1
set wildignore+=*.DS_Store,*.min.*
autocmd BufWinEnter * silent NERDTreeMirror

"-- ULTISNIPS CONFIG
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-l>"

"-- INDENTLINE CONFIG
let g:indentLine_color_gui = '#423d38'
let g:indentLine_setConceal = 0
let g:indentLine_char = '|'
