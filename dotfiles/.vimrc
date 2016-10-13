set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" ========================================================
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'elzr/vim-json'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'morhetz/gruvbox'
Plugin 'nvie/vim-flake8'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" ========================================================
call vundle#end()

" ========================================================
" Theme settings
" ========================================================

syntax on
filetype plugin indent on
syntax enable
set background=dark

if $VIM_THEME == 'gruvbox'
    colorscheme gruvbox
    let g:airline_theme='gruvbox'
endif

if $VIM_THEME == 'solarized'
    colorscheme solarized
    let g:airline_theme='solarized'
    let g:solarized_visibility = "high"
    let g:solarized_contrast = "high"
    let g:solarized_termtrans = 1
endif

" ========================================================
" Personal keybindings
" ========================================================
:noremap p[ :bp <cr>
:inoremap p[ <Esc>:bp <cr>
:noremap p] :bn <cr>
:inoremap p] <Esc>:bn <cr>

:noremap -- :NERDTreeToggle <cr>

let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'


" ========================================================
" airblade/vim-gitgutter settings
" ========================================================

" https://github.com/airblade/vim-gitgutter/issues/164#issuecomment-75758204
highlight clear SignColumn
call gitgutter#highlight#define_highlights()


" ========================================================
" Yggdroot/indentLine settings
" ========================================================
let g:indentLine_char = '│'


" ========================================================
" bling/vim-airline settings
" ========================================================

" vim airline show status bar
set laststatus=2
" vim powerline fonts for arrows
let g:airline_powerline_fonts = 1
" Instead of displaying file encoding, display absolute file path.
let g:airline_section_y = airline#section#create(['%F'])
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'


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
let g:syntastic_python_python_exec = '/usr/local/bin/python3'


" ========================================================
" heavenshell/vim-jsdoc settings
" ========================================================

" Allow prompt for interactive input.
let g:jsdoc_allow_input_prompt = 1

" Prompt for a function description
let g:jsdoc_input_description = 1

" Characters used to separate @param name and description.
let g:jsdoc_param_description_separator	= ' - '


" ========================================================
" elzr/vim-json settings
" ========================================================

" Disable the concealing
let g:vim_json_syntax_conceal = 0


" ========================================================
" More vim settings
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
map g <nop>
map U <nop>

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
set colorcolumn=+1

set splitbelow
set splitright

" Searching
set ignorecase  
set incsearch
set nohlsearch

set backspace=indent,eol,start

" ========================================================
" snippets
" ========================================================

function! SpellCheck()
    let l:word = input("Word you're trying to spell: ")
    let l:result = system($DOTFILES . '/../scripts/spellcheck.py ' . word)
    redraw
    echo l:result
    let @@ = l:result
endfunction 

command SpellCheck :call SpellCheck()

function! TODO()
    let l:timestamp = strftime('%F')
    let l:todo = ' TODO(markl|' . timestamp . '):  '
    :exe ":normal i" . todo
endfunction

command TODO :call TODO()



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
