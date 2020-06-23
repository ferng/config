set noerrorbells
set history
set backspace=eol,start,indent
set wrap
set linebreak
set tabstop=2       "for non-c files only
set shiftwidth=2    "for non-c files only
set expandtab       "for non-c files only
set autoindent
set ruler
set pastetoggle=<F2>
set statusline+=%#warningmsg#
set statusline+=%*%n-%F%r%l,%c
set switchbuf+=usetab,newtab
set diffopt+=iwhite
set shortmess=F

call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'godlygeek/tabular', {'on': 'Onions'}
  Plug 'majutsushi/tagbar'
  Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
  Plug 'leafgarland/typescript-vim', {'for': ['typescript']}
  Plug 'mxw/vim-jsx', {'for': 'javascript.jsx'}
  Plug 'crusoexia/vim-monokai'
  Plug 'vim-syntastic/syntastic', {'for': ['javascript', 'javascript.jsx', 'typescript', 'python']}
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
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_exe = 'pylint'
" let g:syntastic_debug = 63

colorscheme monokai

nmap K                :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nmap M                :call DelMark()<CR>
nmap ,n               :NERDTreeFind<CR>
nmap <F7>             :NERDTreeToggle<CR>
nmap <F8>             :TagbarToggle<CR>
nmap <C-h>            :SyntasticCheck<CR>
nmap <C-p>            :PlugStatus<CR>
nmap <C-S-LEFT>       :tabm -1<CR> 
nmap <C-S-RIGHT>      :tabm +1<CR>
nmap <silent> ,/      :call Comment(getpos('.')[1], getpos("'a")[1])<CR>
nmap <silent><TAB>    :call Indent(getpos('.')[1], getpos("'a")[1], 'indent')<CR>
nmap <silent><S-TAB>  :call Indent(getpos('.')[1], getpos("'a")[1], 'unindent')<CR>

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []
inoremap (      ()<Left>
inoremap ((     (
inoremap ()     ()
inoremap <expr> )   strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> }   strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ]   strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> '   strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'<Left>"
inoremap <expr> "   strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"<Left>"
inoremap <expr> `   strpart(getline('.'), col('.')-1, 1) == "\`" ? "\<Right>" : "\`\`<Left>"

autocmd VimEnter * call s:Open()
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
autocmd FileType c set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
autocmd Filetype * let b:comment = '//'
autocmd Filetype python let b:comment = '#'
autocmd Filetype vim let b:comment = '"'

command! -nargs=1 Find call s:FindFn(<f-args>)
command! -range Com <line1>,<line2>call CommentParse()
command! Fix call FixFn()
command! WP call Writing()
command! WS call WsFn()
command! WL call WriteLint()
command! WF call WriteFixLint()
command! FT call Format()

if executable('ack')
  set grepprg=ack\ --nogroup\ --nocolor
endif

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

function! s:Open()
  if argc() == 0 && !exists("s:std_in")
    if filereadable("fern.sess")
      source fern.sess
      tabedit
      NERDTree
      tabm 0
    else
      NERDTree
		endif
  endif
endfunction

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
  if first == 0
    let first = last
  endif
  if last == 0
    let last = first
  endif
  if last < first
    let first = a:end
    let last = a:start
  endif
  for lineNum in range(first, last)
    let currLine = getline(lineNum)
    if currLine =~ '^' . b:comment . ' '
      let updated = substitute(currLine, '^' . b:comment . ' ', '', '')
    else
      let updated = b:comment . ' ' . currLine
    endif
    call setline(lineNum, updated)
  endfor
endfunction

function! Indent(start, end, action)
  let first = a:start
  let last = a:end
  let action = a:action
  if first == 0
    let first = last
  endif
  if last == 0
    let last = first
  endif
  if last < first
    let first = a:end
    let last = a:start
  endif
  for lineNum in range(first, last)
    call cursor(lineNum, 0)
    if action == 'indent'
      >
    else
      <
    endif
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

function! DelMark()
  let mark = input('>')
  delmarks mark
endfunction

function! Writing()
  map k gk
  map <UP> gk
  map j gj
  map <DOWN> gj
  set spell spelllang=en_gb
  set spellfile=~/.vim/spell/en.utf-8.add
endfunction

function! WsFn()
  tabn 1
  NERDTreeClose
  mks! fern.sess
  NERDTree
endfunction

function! WriteLint()
  write
  SyntasticCheck
endfunction

function! WriteFixLint()
  write
  call FixFn()
  SyntasticCheck
endfunction

function! Format()
  retab!
  call Preserve('normal gg=G')
endfunction

function! Preserve(command)
  let search = @/
  let cursor_position = getpos('.')
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  execute a:command

  let @/ = search
  call setpos('.', window_position)
  normal! zt
  call setpos('.', cursor_position)
endfunction
