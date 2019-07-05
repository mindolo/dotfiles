" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')


Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax',
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'drmingdrmer/vim-tabbar'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
call plug#end()

" styles
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif
colorscheme base16-google-dark
syntax on
set title
set number
set laststatus=2

" soft (80, vertical line) and hard (100, red bg) character caps
set colorcolumn=100
highlight ColorColumn ctermbg=8

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%120v.\+/

" spaces instead of tabs
set tabstop=4
set smarttab
set expandtab
set shiftwidth=4
set softtabstop=4

" misc
set showcmd
set autoindent
set undolevels=1000
set incsearch                                   " incremental search
set hlsearch                                    " highlight search
set hidden                                      " keep buffer undo history
set ignorecase                                  " case insensitive search
set smartcase                                   " case insensitive search if all lower case

" remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

""" Python Nvim Venvs
let g:python_host_prog = '/Users/fpedrini/.virtualenvs/neovim2/bin/python'
let g:python3_host_prog = '/Users/fpedrini/.virtualenvs/neovim3/bin/python'

""" ale config
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_python_flake8_options = '--config ~/.config/flake8.ini'
let g:ale_python_flake8_change_directory = 0
let g:ale_python_autopep8_options = '--global-config ~/.config/flake8.ini'
let g:ale_python_isort_options = '-sp ' . fnamemodify('test-conf', ':p')
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['autopep8', 'isort']}


let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.terraform = '[^ *\t"{=$]\w*'
let g:deoplete#enable_at_startup = 1
call deoplete#initialize()
let g:airline#extensions#ale#enabled = 1

