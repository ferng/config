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
set switchbuf+=usetab,newtab

call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'godlygeek/tabular', {'on': 'Onions'}
  Plug 'majutsushi/tagbar'
  Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
  Plug 'leafgarland/typescript-vim', {'for': ['typescript']}
  Plug 'mxw/vim-jsx', {'for': 'javascript.jsx'}
  Plug 'crusoexia/vim-monokai'
  Plug 'vim-syntastic/syntastic', {'for': ['javascript', 'javascript.jsx', 'typescript']}
call plug#end()

let g:javascript_plugin_jsdoc = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 0
let g:syntastic_id_checkers = 1
let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'node_modules/.bin/eslint'
let g:syntastic_javascript_eslint_exec = '/bin/ls' "hack for syntastic bug
let g:syntastic_typescript_checkers = ['typescript/tslint']
let g:syntastic_typescript_tslint_exe = 'node_modules/.bin/tslint'
let g:syntastic_typescript_tslint_exec = '/bin/ls' "hack for syntastic bug
"let g:syntastic_debug = 63

colorscheme monokai

nmap <C-n> :NERDTreeToggle<CR>
nmap ,n :NERDTreeFind<CR>
nmap <C-h> :SyntasticCheck<CR>
nmap <F8>  :TagbarToggle<CR>
nmap <C-p> :PlugStatus<CR>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nmap <silent> ,. :call Comment(getpos('.')[1], getpos('.')[1])<CR>
nmap <silent> ,/ :call Comment(getpos('.')[1], getpos("'a")[1])<CR>

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []
inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"

autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

command! -nargs=1 Find call s:FindFn(<f-args>)
command! -range Com <line1>,<line2>call CommentParse()
command! Fix call FixFn()

if executable('ack')
  set grepprg=ack\ --nogroup\ --nocolor
endif

function! s:FindFn(str)
  if !empty(a:str)
    execute 'silent grep' a:str | copen
  endif
  redraw!
endfunction

function! CommentParse() range
  call Comment(a:firstline, a:lastline)
endfunction

function! Comment(start, end)
  let first = a:start
  let last = a:end
  if a:end < a:start
    let first = a:end
    let last = a:start
  endif
  for lineNum in range(first, last)
    let currLine = getline(lineNum)
    if currLine =~ '^\/\/ '
      let updated = substitute(currLine, '^\/\/ ', '', '')
    else
      let updated = '// ' . currLine
    endif
    call setline(lineNum, updated)
  endfor
endfunction

function! FixFn()
  let file = expand('%:p')
  let projRoot = getcwd()
  let ext = expand('%:e')
  if ext == 'js'
    :call system(projRoot.'/node_modules/.bin/eslint -c '.projRoot.'/.eslintrc.json --fix '.file)
  elseif ext == 'jsx'
    :call system(projRoot.'/node_modules/.bin/eslint -c '.projRoot.'/.eslintjsxrc.json --fix '.file)
  elseif ext == 'ts'
    :call system(projRoot.'/node_modules/.bin/tslint --project '.projRoot.'/tsconfig.json --fix '.file)
  endif
  :e
endfunction
