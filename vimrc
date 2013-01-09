"" Inspiration:
"" https://github.com/mislav/vimfiles
"" https://github.com/carlhuda/janus
"" https://github.com/akitaonrails/vimfiles


""
"" Load plugins
""

call pathogen#infect()
filetype plugin indent on


""
"" Basic
""

set nocompatible    " Use vim defaults
set encoding=utf-8  " utf-8 as default encoding
set number          " Show line numbers
set ruler           " Show line and column numbers
syntax enable       " Syntax highlighting
set showcmd     " show partial commands below the status line
set shell=bash  " avoids munging PATH under zsh
let g:is_bash=1 " default shell syntax
set history=500 " remember more Ex commands
set scrolloff=3 " have some context around the current line always on screen
let mapleader=","
let maplocalleader = ","
set hidden      " backgrounding buffers
:au FocusLost * silent! wa " save all files after focus is lost


""
"" Look
""

set colorcolumn=80

if has("gui_running")
  "tell the term has 256 colors
  set t_Co=256

  set guioptions=egmrt " Tabs, grey menu items, menu bar, right scrollbar, tearoff menu items 
  set guioptions-=T    " No toolbar
  colorscheme Tomorrow-Night

  if has("gui_macvim") || has("gui_mac")
    set guifont=Menlo\ Regular:h12
    " set guifont=AnonymousPro:h12
    set linespace=2 " Space between lines
    set antialias
    set fuoptions=maxhorz,maxvert " Fullscreen takes up entire screen
    set columns=115 " width of window in characters
  end
else
  set background=dark
  if $TERM == 'xterm'
      set term=xterm-256color
      colorscheme wombat256
  else
      colorscheme default
  endif
endif


""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters

if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
set backspace=indent,eol,start    " backspace through everything in insert mode


""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter


""
"" Remaps
""

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" disable cursor keys in normal mode
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

" change directory to the currently open file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" cycle between current and previous buffer
nnoremap <leader><leader> <c-^>

" move by screen line
nnoremap j gj
nnoremap k gk

" remove mapping of F1
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" ,v and ,h to open new splits
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j

"
imap jj <Esc>

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

""
"" Status line
""

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar
  " Start the status line
  set statusline=%f\ %m\ %r

  " Add fugitive
  set statusline+=%{fugitive#statusline()}

  " Finish the statusline
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

set backupdir=~/.vim/_backup//    " where to put backup files.
set directory=~/.vim/_temp//      " where to put swap files.


""
"" Commands
""

set wildmode=list:longest                    "make cmdline tab completion similar to bash
set wildmenu                                 "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~                  "stuff to ignore when tab completing
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX


""
"" Control whitespace preferences based on filetype, uses autocmd
"" 
if has("autocmd")
  " enable file type detection
  filetype on

  " syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

  " non ruby files related to Ruby
  autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile setfiletype ruby

  autocmd BufNewFile,BufRead Rakefile setfiletype rake
  autocmd BufNewFile,BufRead Rakefile set syntax=ruby

  autocmd BufNewFile,BufRead *.rake setfiletype rake
  autocmd BufNewFile,BufRead *.rake set syntax=ruby

  " Python specific settings
  let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
  autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtab

  " Java specific settings
  autocmd BufNewFile,BufRead *.java set ts=4 sts=4 sw=4 expandtab

  " TeX specific settings
  autocmd BufNewFile,BufRead *.tex colorscheme wombat256
  autocmd BufNewFile,BufRead *.tex set wrap
  autocmd BufNewFile,BufRead *.tex setf tex
  autocmd BufNewFile,BufRead *.tex set colorcolumn=0

  " Markdown specific settings
  autocmd BufNewFile,BufRead *.md set wrap
  autocmd BufNewFile,BufRead *.md set colorcolumn=0
endif


""
"" Plugins
""

runtime macros/matchit.vim

" nerdtree
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 25
map <F2> :NERDTreeToggle<CR>

 "nercommenter
map \\ <Plug>NERDCommenterToggle<CR>
map <D-/> <Plug>NERDCommenterToggle<CR>
imap \\ <Esc><Plug>NERDCommenterToggle i

" ack
nnoremap <leader>a :Ack<space>

" ctrlp
let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn)$'

