set nocompatible

" first clear any existing autocommands:
autocmd!

call pathogen#infect()

" * User Interface

" Colorscheme
colorscheme solarized
"set background=dark "solarized supports light, too!

if (!has('gui_running'))
  set bg=dark 
else 
  set bg=light 
endif 
hi clear 

" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
  syntax on
endif

" have fifty lines of command-line (etc) history:
set history=50
" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

" don't have files trying to override this .vimrc:
set nomodeline

" * Text Formatting -- General

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

set list
set listchars=tab:▸\ ,eol:¬

set shiftwidth=2 "number of spaces to use for each step of indent
set softtabstop=2 "number of spaces that a tab counts for
set tabstop=2 "number of spaces that a tab in a file counts for
set expandtab
set autoindent

" * Text Formatting -- Specific File Formats

set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set laststatus=2
set relativenumber
set undofile

" enable filetype detection:
filetype on
filetype plugin indent on

" * Search & Replace

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

" * Keystrokes -- Moving Around

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode:
set whichwrap=h,l,~,[,]

" * Keystrokes -- Insert Mode

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

let mapleader = ","

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %



"disable arrowkeys: no wussy stuff

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

"ctrl+hjkl to move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"disable help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap ; :

"swap between relative and absolute line numbers
nnoremap <leader>l :exe 'set ' . (&relativenumber ? 'number' : 'relativenumber')<return>

nnoremap <leader><tab> :NERDTreeToggle<return>

nnoremap <leader>` :noh<return>

"autosave when focus is lost
au FocusLost * :wa

"set c mode to use indicator $
set cpoptions+=$

"gui font settings
set guifont=Menlo:h11

"macvim gui options
if has("gui_running")
    set guioptions=aAcet
endif
