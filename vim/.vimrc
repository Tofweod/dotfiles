inoremap jf <esc>
cnoremap jf <c-c>
let mapleader = " "
set nocompatible
set nosmartindent
set autoindent
set noincsearch
set title
set modeline
set modelines=6
set encoding=utf-8
set belloff=all
set number
set backspace=2
set tabstop=4
set shiftwidth=4
set ignorecase
set showmode
set showcmd
set mouse=a
set autoindent
set relativenumber
set t_Co=16
set textwidth=80
set wrap
set ruler
set showmatch
" set autochdir
set autoread
set laststatus=2
set hidden
set undofile

set undodir=~/.vim/undodir

set jumpoptions=stack


highlight Error NONE

nnoremap <leader>nhl :nohl<CR>

nnoremap <leader>q :qall<CR>
nnoremap <leader>w :w<CR>

nnoremap <leader>wh :split<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wd :close<CR>

nnoremap <leader>bd :bdelete<CR>

nnoremap <enter> o<esc>

function! Home()
	let l:line = getline('.')
	let l:cursor = getpos('.')

	let l:head = match(l:line,'\S')

	let l:head = l:head == -1 ? 0 :l:head

	let l:cursor[2] = l:cursor[2] == l:head+1? 1: l:head+1
	call setpos('.',l:cursor)
endfunction

nnoremap <Home> :call Home()<CR>
inoremap <Home> <Esc>:call Home()<CR>a

nnoremap 0 :call Home()<CR>
onoremap 0 :call Home()<CR>
vnoremap 0 :call Home()<CR>



let plugpath = expand("~/.plugrc.vim")
if filereadable(plugpath)
	execute 'source' . plugpath
endif

let autocmdpath = expand("~/.autocmdrc.vim")
if filereadable(autocmdpath)
	execute 'source' . autocmdpath
endif
