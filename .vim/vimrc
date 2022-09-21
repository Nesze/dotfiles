" Started off from vimrc_example.vim


" alternatively, pass a path where Vundle should install plugins
" e.g. call vundle#begin('~/some/path/here')
call plug#begin()
  " general
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'majutsushi/tagbar'
  Plug 'scrooloose/nerdtree'
  Plug 'SirVer/ultisnips'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'mzlogin/vim-markdown-toc'
  Plug 'neoclide/coc.nvim', {'branch':'release'}

  " lang
  Plug 'fatih/vim-go'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'hashivim/vim-terraform'
  Plug 'mxw/vim-jsx'
  Plug 'pangloss/vim-javascript'
  Plug 'rust-lang/rust.vim'
  Plug 'uarun/vim-protobuf'

  " themes
  Plug 'dracula/vim'
  Plug 'fatih/molokai'

  " tmux
  Plug 'christoomey/vim-tmux-navigator'

" All of your Plugins must be added before the following line
call plug#end()

" required
filetype plugin indent on


" coc
" completion improvements
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" TODO why "\<Tab>" does not work
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" TODO why it doesn't work
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Auto-completion changes
" Move up and down in autocomplete with <c-j> and <c-k>
inoremap <expr> <c-j> "\<C-n>"
inoremap <expr> <c-k> "\<C-p>"

" fzf remappings
nnoremap <silent> <leader>F :Files<CR>
nnoremap <silent> <leader>f :Rg<CR>
nnoremap <silent> <leader>B :Buffers<CR>

set completeopt-=preview

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep a backup file (restore to previous version)
set undofile		" keep an undo file (undo changes after closing)
set history=5000	" keep 5000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set wildmenu		" visual autocomplete for cmd menu
set lazyredraw		" redraw only when we need to
set hidden		" possibility to have more than one unsaved buffers

set undodir=~/.vim/tmp/.undo//
set backupdir=~/.vim/tmp/.backup//
set directory=~/.vim/tmp/.swp//

" `matchit.vim` is built-in so let's enable it!
" Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim

" hashivim
let g:terraform_fmt_on_save = 1

" Don't use Ex mode, use Q for formatting
" TODO make this useful
map Q gq

nnoremap <F5> mzgg=G`z

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>


" vim-go --->

" syntax highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1


" bindings
au FileType go nmap <leader>r <Plug>(go-rename)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>T <Plug>(go-test-func)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>a <Plug>(go-alternate-edit)
au FileType go nmap <leader>gr <Plug>(go-referrers)
au FileType go nmap <leader>gc <Plug>(go-callers)
au FileType go nmap <leader>ge <Plug>(go-callees)
au FileType go nmap <leader>gs <Plug>(go-implements)
au FileType go nmap <F3> :GoDeclsDir<CR>
au FileType go nmap <F4> :GoFmt<CR>
" au FileType go nmap <F2> <Plug>(go-run)
"au FileType go nmap <leader>gf <Plug>(go-decls)
"au FileType go nmap <leader>gF <Plug>(go-decls-dir)

" more options for opening alternate files
au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" tab = 4 space (default is 8)
au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" no more :w before running go cmds (build/run/test)
set autowrite

let g:go_gopls_gofumpt = v:true
" disable location list by using quickfix window instead
let g:go_list_type = 'quickfix'

let g:go_test_timeout = '10s'
let g:go_metalinter_command = 'golangci-lint'
let g:go_metalinter_enabled = ['vet', 'revive', 'unconvert','unparam', 'gofmt', 'unused']
let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['vet', 'revive']
let g:go_metalinter_deadline = "10s"

" show type info in status bar
let g:go_auto_type_info = 1
set updatetime=200

let g:go_decls_includes = "func,type"

let g:go_gocode_propose_source = 0

" let g:go_addtags_transform = "camelcase"

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0


" auto highlight type usages
"let g:go_auto_sameids = 1

" <--- End of vim-go config
"

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <C-q> :cclose<CR>

" easier window navigation
map <C-w><C-h> <C-h>
map <C-w><C-j> <C-j>
map <C-w><C-k> <C-k>
map <C-w><C-l> <C-l>
" default is <C-l>
map <F2> :redraw!<CR>

autocmd FileType help noremap <buffer> q :q<cr>

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

nmap <F8> :TagbarToggle<CR>

"statusline

set laststatus=2

" function! GitBranch()
"   return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction

" function! StatuslineGit()
"   let l:branchname = GitBranch()
"   return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
" endfunction

" set statusline=
" set statusline+=%#PmenuSel#
" set statusline+=%{StatuslineGit()}
" set statusline+=%#LineNr#
" set statusline+=\ %f
" set statusline+=%m\
" set statusline+=%=
" set statusline+=%#CursorColumn#
" set statusline+=\ %y
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\[%{&fileformat}\]
" set statusline+=\ %p%%
" set statusline+=\ %l:%c
" set statusline+=\ 

" autocmd FileType go let completefunc=&omnifunc

" nerdtree bindings
map <C-\> :NERDTreeToggle<CR>
" nerdtree options
" unideal / would be better to re-use gitignore
let NERDTreeIgnore=['\--$', '\~$']

" syncn NERDTree with opened file
"autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co >= 256 || has("gui_running")
  syntax on
  
  let g:molokai_original = 1
  let g:rehash256 = 1
  colorscheme molokai

  set hlsearch
endif

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" disable this - saving large files way too slow
" TODO
" folding
"set foldmethod=syntax
"set nofoldenable

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

set nu

" Spaces are better than a tab character
"set expandtab
"set smarttab

" Who wants an 8 character tab?  Not me!
"set shiftwidth=4
"set softtabstop=4

" yank and paste to & from VIM as well"
set clipboard=unnamed

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" rusty
let g:rustfmt_autosave = 1
