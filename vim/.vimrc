set noerrorbells
set history
set tabstop=2
set backspace=eol,start,indent
set wrap
set shiftwidth=2
set linebreak
set autoindent
set ruler
set expandtab
set pastetoggle=<F2>
set statusline+=%#warningmsg#
set statusline+=%*

call plug#begin('~/.vim/plugged')
  Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
  Plug 'mxw/vim-jsx', {'for': 'javascript.jsx'}
  Plug 'vim-syntastic/syntastic', {'for': ['javascript', 'javascript.jsx']}
  Plug 'crusoexia/vim-monokai'
  Plug 'godlygeek/tabular'
  Plug 'scrooloose/nerdtree'
call plug#end()

let g:javascript_plugin_jsdoc = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
let g:syntastic_javascript_eslint_exec = '/bin/ls' "hack for syntastic bug
colorscheme monokai

map <C-n> :NERDTreeToggle<CR>
map <C-h> :SyntasticCheck<CR>

autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

syntax on
