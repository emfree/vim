" Credit: http://stackoverflow.com/questions/164847/what-is-in-your-vimrc

" Automatically close braces
:inoremap {<CR>  {<CR>}<Esc>O

" Max linewidth: 79 columns
set tw=79

" Use color column
set colorcolumn=80

"{{{Auto Commands

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

"}}}


" Ctags
map <C-L> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
set tags=~/.vim/stdtags,tags,.tags,../tags
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


"{{{Misc Settings

"Solarized is the best colorscheme
set background=dark
set t_Co=16
colorscheme solarized

" Necessary for lots of cool vim things
set nocompatible

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'gmarik/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on


" This shows what you are typing as a command.  I love this!
set showcmd

syntax on
set grepprg=grep\ -nH\ $*

set gcr=a:blinkon0
set hls is ic scs
set sw=4 sts=4 et

set autoindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Cool tab completion stuff
 set wildmenu
 set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Got backspace?
set backspace=2

" Line Numbers
set number

set smartcase

" Remap jj to escape in insert mode.
inoremap jj <Esc>

nnoremap JJJJ <Nop>

" Incremental searching.
set incsearch

" Highlight things that we find with the search
set hlsearch

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" When I close a tab, remove the buffer
set nohidden

" Set off the other paren
highlight MatchParen ctermbg=4
" }}}

"{{{Look and Feel

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]
" }}}

"{{{ Functions

"{{{ Paste Toggle
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc
"}}}

"}}}

"{{{ Mappings

" Open Url on this line with the browser \w
map <Leader>w :call Browser ()<CR>

" Open the Project Plugin <F2>
nnoremap <silent> <F2> :Project<CR>

" Open the Project Plugin
nnoremap <silent> <Leader>pal  :Project .vimproject<CR>

" Open the TagList Plugin <F3>
nnoremap <silent> <F3> :Tlist<CR>

" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>:CtrlP<CR>

" DOS is for fools.
nnoremap <silent> <F9> :%s/$//g<CR>:%s// /g<CR>

" Paste Mode!  Dang! <F10>
nnoremap <silent> <F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vim/vimrc<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Fast-ish scrolling
nnoremap <silent> <S-Up> 5kzz
nnoremap <silent> <S-Down> 5jzz

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Testing
set completeopt=longest,menuone,preview

inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" Fix email paragraphs
nnoremap <leader>par :%s/^>$//<CR>

"}}}

"{{{Taglist configuration
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0
" use exuberant ctags installation in .vim/ctags
let Tlist_Ctags_Cmd = '~/.vim/ctags/ctags'

"}}}

let g:rct_completion_use_fri = 1

set clipboard=unnamedplus

" CtrlP configuration
let g:ctrlp_custom_ignore = '\v\.pyc$'


" Swapfiles are really more annoying than they're worth
set noswapfile

" pathogen
execute pathogen#infect()

" Disable Background Color Erase to fix mouse / Ctrl-arrow keys
" Why? I have no idea.
" http://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux
set t_ut=
