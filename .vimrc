set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" ========================================================
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'elzr/vim-json'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'kien/ctrlp.vim'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'nvie/vim-flake8'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/syntastic'
Plugin 'wikitopian/hardmode'
" Plugin 'wookiehangover/jshint.vim'
" ========================================================
Bundle 'edkolev/tmuxline.vim'
" ========================================================
call vundle#end()

" theme settings

syntax on
filetype plugin indent on
" let g:solarized_termcolors=256
syntax enable
set background=dark
 colorscheme solarized
" colorscheme monokai
set cursorline
" set t_Co=256  " vim-monokai now only support 256 colours in terminal.
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termtrans = 1

" ========================================================
" bling/vim-airline settings
" ========================================================

" vim airline show status bar
set laststatus=2
" vim powerline fonts for arrows
let g:airline_powerline_fonts = 1
" Instead of displaying file encoding, display absolute file path.
let g:airline_section_y = airline#section#create(['%F'])

" ========================================================
" scrooloose/syntastic settings
" ========================================================

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']

" ========================================================
" heavenshell/vim-jsdoc settings
" ========================================================

" Allow prompt for interactive input.
let g:jsdoc_allow_input_prompt = 1

" Prompt for a function description
let g:jsdoc_input_description = 1

" Don't add the @return tag.
let g:jsdoc_return = 0
let g:jsdoc_return_type = 0

" Characters used to separate @param name and description.
let g:jsdoc_param_description_separator	= ' - '

" ========================================================
" elzr/vim-json settings
" ========================================================

" Disable the concealing
let g:vim_json_syntax_conceal = 0

" ========================================================
" vim settings
" ========================================================

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

" make splits faster in tmux
" http://unix.stackexchange.com/a/240693
set lazyredraw
set ttyfast

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

" set ruler
set colorcolumn=80

" ========================================================
" snippets
" ========================================================

function! SpellCheck()
    let l:word = input("Word you're trying to spell: ")
    let l:result = system('/nail/home/markl/scripts/spellcheck.py ' . word)
    redraw
    echo l:result
    let @@ = l:result
endfunction 

command SpellCheck :call SpellCheck()



" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
