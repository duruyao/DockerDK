set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
 
set shiftwidth=4    "Number of spaces to use for each step of (auto)indent.
 
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
 
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.
 
set showcmd         " Show (partial) command in status line.

set number          " Show line numbers.

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.
  
set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
 
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
 
set ignorecase      " Ignore case in search patterns.
 
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
 
set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.
 
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
 
set textwidth=120   " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.
 
set formatoptions=c,q,r,t   " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode. 
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)
 
set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.
 
set mouse=a         " Enable the use of the mouse.

set background=dark " Make color of vim is same inside Gnome terminal and inside 
                    " tmux terminal.

set t_Co=256
 
execute pathogen#infect()
syntax on
filetype plugin indent on

"" Configurations Of NERDTree

map <F2> :NERDTreeToggle<CR>            " Set 'F2' as switcher.

let g:NERDTreeDirArrowExpandable = '+'  " Modified logo of tree.

let g:NERDTreeDirArrowCollapsible = '-'

let g:NERDTreeWinPos='left'             " Set position of window.

let g:NERDTreeWinSize=30                " Set size of window.

let g:NERDTreeShowLineNumbers=0         " Show line numbers.

let g:NERDTreeHidden=0                  " Show hidden file.

autocmd vimenter * if !argc() | NERDTree | endif    
                                        " Show NERDTree when open vim but no file.
