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
Bundle 'tpope/vim-fugitive'
Bundle 'fatih/vim-go'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'scrooloose/syntastic'
Bundle 'mtscout6/vim-cjsx'
Bundle 'kien/ctrlp.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'rust-lang/rust.vim'
Bundle 'hashivim/vim-terraform'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
call vundle#end()
filetype plugin indent on


" This shows what you are typing as a command.  I love this!
set showcmd

syntax on
set grepprg=grep\ -nH\ $*

set hls is ic scs
set sw=4 ts=4 sts=4 et

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
set relativenumber number

set smartcase

" Remap jj to escape in insert mode.
inoremap jj <Esc>
inoremap jk <Esc>
inoremap kj <Esc>

nnoremap JJJJ <Nop>

" Incremental searching.
set incsearch

" Highlight things that we find with the search
set hlsearch

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

" Default register = linux clipboard
set clipboard=unnamedplus

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
nnoremap <Space> :w<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

set completeopt=longest,menuone

inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" Set breakpoint in Python
nnoremap <silent> <Leader>pdb oimport pdb; pdb.set_trace()<CR><Esc>

nnoremap <silent> <Leader>stop o# STOPSHIP(emfree)

" Replace word under cursor with default buffer contents
nnoremap <silent> <Leader>r "_diwP

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

" CtrlP configuration
let g:ctrlp_custom_ignore = '\v\.pyc$'
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'


" Swapfiles are really more annoying than they're worth
set noswapfile

" Disable Background Color Erase to fix mouse / Ctrl-arrow keys
" Why? I have no idea.
" http://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux
set t_ut=


let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_add_preview_to_completeopt=0
let g:rct_completion_use_fri = 1
let g:go_fmt_command = "goimports"
let g:rustfmt_autosave = 1
let g:ycm_rust_src_path="/home/emfree/repos/rust/src"
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['eslint']
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']


" Quit if quickfix window is last
" http://vim.wikia.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction
