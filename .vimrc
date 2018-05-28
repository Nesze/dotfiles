" Started off from vimrc_example.vim
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Settings from vundle --->
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	Plugin 'gmarik/Vundle.vim'
	Plugin 'scrooloose/nerdtree'
	Plugin 'tpope/vim-fugitive'
	Plugin 'tpope/vim-rhubarb'
	Plugin 'rust-lang/rust.vim'
	Plugin 'editorconfig/editorconfig-vim'
	Plugin 'dracula/vim'
	Plugin 'hashivim/vim-terraform'
	Plugin 'pangloss/vim-javascript'
	Plugin 'mxw/vim-jsx'

	Plugin 'fatih/vim-go'
	Plugin 'AndrewRadev/splitjoin.vim'
	Plugin 'SirVer/ultisnips'
	Plugin 'fatih/molokai'
	Plugin 'ctrlpvim/ctrlp.vim'
	Plugin 'maralla/completor.vim'
	Plugin 'majutsushi/tagbar'

	Plugin 'jiangmiao/auto-pairs'

	Plugin 'tpope/vim-surround'
	Plugin 'tpope/vim-commentary.git'
	" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" <--- End of vundle settings

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set wildmenu		" visual autocomplete for cmd menu
set lazyredraw		" redraw only when we need to
set showmatch		" highlight matching [{()}]

" vim-go syntax highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" hashivim
let g:terraform_fmt_on_save = 1

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.

inoremap <C-U> <C-G>u<C-U>

" vim-go misc
let g:go_fmt_command = "goimports"

" vim-go bindings
au FileType go nmap <leader>r <Plug>(go-rename)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>T <Plug>(go-test-func)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>a <Plug>(go-alternate-edit)
au FileType go nmap <leader>gr <Plug>(go-referrers)
au FileType go nmap <leader>gc <Plug>(go-callers)
au FileType go nmap <leader>ge <Plug>(go-callees)
au FileType go nmap <leader>gs <Plug>(go-implements)
au FileType go nmap <F2> <Plug>(go-run)
" go-doc shortcut is K by default
"au FileType go nmap <F3> <Plug>(go-doc)
"au FileType go nmap <leader>gf <Plug>(go-decls)
"au FileType go nmap <leader>gF <Plug>(go-decls-dir)

"---------------------------------------------------
" vim-go improvements following the vim-go-tutorial
" no more :w before running go cmds (build/run/test)
set autowrite

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <C-x> :cclose<CR>

" disable location list by using quickfix window instead
let g:go_list_type = "quickfix"

" default is 10s. nonetheless, make this visible
let g:go_test_timeout = '10s'

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

" more highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1

" tab = 4 space (default is 8)
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" make these visible (even though they probably are the default)
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"

" show type info in status bar
let g:go_auto_type_info = 1
set updatetime=100
"
" auto highlight type usages
"let g:go_auto_sameids = 1

" make this visible
let g:go_decls_includes = "func,type"

" more options for opening alternate files
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')


let g:completor_gocode_binary = '/Users/zoltanbodor/Dev/go/bin/gocode'

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

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

"end of vim-go config / improvements
"-----------------------------------

" Auto-completion changes
" Move up and down in autocomplete with <c-j> and <c-k>
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

set completeopt-=preview

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
if &t_Co > 2 || has("gui_running")
  syntax on
  
  colorscheme molokai
  "set t_Co=256
  "let g:molokai_original = 1
  "let g:rehash256 = 1

  set hlsearch
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
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

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
