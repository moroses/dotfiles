" Behavior
" =======
set nocompatible		        " disable vi backwards compatibilty
set backspace=indent,eol,start 	  	" fixes backspace & del behavior
set timeoutlen=1000 ttimeoutlen=0 	" No delay for ESC
nmap Q <nop>				" disable ex mode prompt
set bo=all
set autoread 	" Automatically reload files that have been changed outside of Vim
set confirm 	" confirm before exiting if files have not been saved
set hidden 	" Hide buffers when they are abandoned


" UI
" ===
set number				" show line numbers (disable with nonumber)
set relativenumber
noremap <UP> :echo "Nope."
noremap <DOWN> :echo "Nope."
noremap <LEFT> :echo "Nope."
noremap <RIGHT> :echo "Nope."
set laststatus=2
set encoding=utf-8 " Necessary to show Unicode glyphs
set statusline=%f     " show relative path in status line
let g:netrw_liststyle=3       " Explore set to tree view
let g:netrw_usetab=1
set completeopt=longest,menuone " doesn't select first item; insert longest common text; always show menu
set sidescroll=1 " The minimal number of columns to scroll horizontally.
set t_Co=256 " 256 colors
" Spell language
set spelllang=en_us

" first tab completed to the longest common match, or full match,
" second tab completed to show list of all matches,
" third tab starts to cycle through matches
set wildmode=longest,list,full
set wildmenu

" The following command scrolls the text so that (when possible) there are always at least
" five lines visible above the cursor, and five lines visible below the cursor.
" This option is available to all commands
set scrolloff=5

" Editing
" =======

autocmd Filetype css set tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype javascript set tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType html setl tabstop=4 shiftwidth=4 softtabstop=4 filetype=html.javascript

"set expandtab " converts tabs to spaces
set nowrap " don't use word wrap
set textwidth=0 " if word wrap is enabled, this is the max character length
set indentkeys-=<:> " Don't indent after typing a colon (annoying!!!)
set spell " Spell checker defaults to off
autocmd BufWritePre * :%s/\s\+$//e " Remove any and all trailing whitespace

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Folding
" ======
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set foldlevel=1         "this is just what i use
set foldlevelstart=100  " keep first 100 levels of folds open as default
set nofoldenable        " don't enable folds till they are interacted with

" Search
" ======
set ignorecase			        " case insensitive search
set smartcase			        " case sensitive if uppercase
set incsearch			        " move the cursor to first result
set showmatch 	" Show matching brackets.
noremap <F4> :set hlsearch! hlsearch?<CR>

" Toggle spell check
nmap <F7> :set spell! spell?<CR>

" Backups
" =======
set nobackup
set noswapfile

" Ensure syntax highlighting & filetype detecton are turned on
syntax on
filetype plugin indent on

" Mappings
" ========
" LaTeX compile
" =============
imap <C-L> <ESC> :w:!pdflatex % i

" LaTeX shortcuts
" ===============

autocmd FileType tex set relativenumber
autocmd FileType tex inoremap <leader><SPACE> <ESC>/<++><CR>"_c4l
autocmd FileType tex inoremap ;a \begin{align}<CR><CR>\end{align}<CR><++><ESC>2ki
autocmd FileType tex inoremap ;A \begin{align*}<CR><CR>\end{align*}<CR><++><ESC>2ki
autocmd FileType tex inoremap ;sec \section{}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;ssec \subsection{}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;l \label{}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;ls \label{sec:}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;le \label{eq:}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;lf \label{fig:}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;lt \label{tab:}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;b \begin{block}{}<CR><++><CR>\end{block}<CR><++><ESC>3k^f}f}i
autocmd FileType tex inoremap ;ba \begin{alertblock}{}<CR><++><CR>\end{alertblock}<CR><++><ESC>3k^f}f}i
autocmd FileType tex inoremap ;be \begin{exampleblock}{}<CR><++><CR>\end{exampleblock}<CR><++><ESC>3k^f}f}i


" Tab in normal mode toggles file browsing
nmap <TAB> :40Lexplore <CR>
" When autocomplete popup is open, enter just inserts selected item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" navigate quickfix locations
nmap ]q :lnext<cr>
nmap [q :lprevious<cr>

" navigate location list
nmap ]w :cnext<cr>
nmap [w :cprevious<cr>

" toggle last buffer
nmap <LEADER>b :b# <CR>

" Navigate splits with CTRL+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move Lines [e and ]e (ALL MODES)
" up
nmap ]e mz:m-2<cr>`z==
imap ]e <esc>:m-2<cr>==gi
vmap ]e :m'<-2<cr>gv=`>my`<mzgv`yo`z

" down
nmap [e mz:m+<CR>`z==
vmap [e :m'>+<CR>gv=`<my`>mzgv`yo`z
imap [e <Esc>:m+<CR>==gi

" Faster saves
nnoremap ,s :w<CR>
nnoremap ,w :w<CR>
" Faster closing of buffers
noremap Q :q<cr>

" Jump list mappings
" go back in jump list
map ,o <C-o>
" go forwards in jump list
map ,i <C-i>

" Fixing my own common mistakes
" ==============================
cnoreabbrev regs reg
cnoreabbrev Ag Ag!
cnoreabbrev ag Ag!
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev Qa qa
cnoreabbrev Tabe tabe

" Colors
" =======
colorscheme desert    " use this color scheme
set background=dark   " adapt colors for background

hi clear SpellBad
hi SpellBad cterm=undercurl ctermfg=red

" Change diff colors
hi DiffAdd    cterm=bold ctermfg=black ctermbg=10 gui=none guifg=black guibg=green
hi DiffDelete cterm=bold ctermfg=black ctermbg=9 gui=none guifg=black guibg=Red
hi DiffChange cterm=bold ctermfg=black ctermbg=17 gui=none guifg=bg guibg=Red
hi DiffText   cterm=bold ctermfg=black ctermbg=88 gui=none guifg=bg guibg=Red

" Sets popup and selection colors
hi Pmenu ctermbg=246 ctermfg=232
hi PmenuSel ctermbg=237 ctermfg=250

