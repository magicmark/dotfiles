set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'nvie/vim-flake8'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'airblade/vim-gitgutter'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'elzr/vim-json'
call vundle#end()

syntax on
filetype plugin indent on

syntax enable
set background=dark
colorscheme solarized

" vim airline show status bar
set laststatus=2
" vim powerline fonts for arrows
let g:airline_powerline_fonts = 1

" Instead of displaying file encoding, display absolute file path.
let g:airline_section_y = airline#section#create(['%F'])


" line numbers
set number

" tabs to spaces
" size of a hard tabstop
set tabstop=4
" always uses spaces instead of tab characters
set expandtab
" size of an "indent"
set shiftwidth=4

imap jj <Esc>

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Relative numbers
set relativenumber

" Shorten escape insert mode time
set timeoutlen=200

" With buffers, don't force save (http://usevim.com/2012/10/19/vim101-set-hidden/)
set hidden

