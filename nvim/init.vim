call plug#begin()
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
" fancy
Plug 'ap/vim-css-color'
Plug 'NLKNguyen/papercolor-theme'
Plug 'lifepillar/vim-gruvbox8'
Plug 'luochen1990/rainbow'
call plug#end()

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" English spell check
" set spell
" set spelllang=en

filetype plugin indent on
set encoding=UTF-8
set mouse=a
set clipboard=unnamedplus
set nohlsearch

set tabstop=4 softtabstop=4
set shiftwidth=4
" 4 space in html, css look non-fancy, 2 space is better
autocmd BufRead,BufNewFile *.css,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2
" convert tab to space, some issue when I see file at github,...
set expandtab

set number relativenumber
syntax enable

" set statusline=%F%m%r%h%w
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)

set autowrite
set autoread
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.config/nvim/undodir
set undofile

set autoindent
set smartindent

" remap Esc
:imap jj <Esc>
" Map leader to space
map <space> <leader>

" Display different types of white spaces
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" highlight cursorline
set cursorline
highlight CursorLine term=bold cterm=bold
highlight CursorLine guibg=253 ctermbg=253

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" theme
set termguicolors
" papercolor-theme
" set background=light
" colorscheme PaperColor

set background=dark
colorscheme gruvbox8

" rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" easymotion
nmap <silent> ;; <Plug>(easymotion-overwin-f)
nmap <silent> ;l <Plug>(easymotion-overwin-line)

" nerdcommenter
let g:NERDSpaceDelims = 1
map mm <Plug>NERDCommenterToggle

" fzf
noremap <leader>t :Files<CR>
noremap <leader>b :Buffers<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-f> <plug>(fzf-complete-path)

" Advanced customization using Vim function
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" emmet
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" coc vim
let g:coc_global_extensions = [
                        \ "coc-css",
                        \ "coc-html",
                        \ "coc-snippets",
                        \ "coc-json",
                        \ "coc-python",
                        \ "coc-clangd",
                        \ "coc-import-cost",
                        \ "coc-sh",
                        \ "coc-tsserver",]

" if hidden is not set, TextEdit might fail.
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" auto insert when open file
autocmd BufNewFile *.sh  :call CheckShFile()
autocmd BufNewFile *.fish  :call CheckFishFile()
autocmd BufNewFile *.py :call CheckPyFile()
autocmd BufNewFile *.cpp :call CheckCppFile()

function! CheckShFile()
    normal!i#!/usr/bin/env sh
    normal!o
endfunction

function! CheckPyFile()
    normal!i#!/usr/bin/env python3
    normal!o
endfunction

function! CheckCppFile()
    normal!i#include <iostream>
    normal!ousing namespace std;
    normal!o
    normal!oint main() {
    normal!oreturn 0;
    normal!o}
endfunction

function! CheckFishFile()
    normal!i#!/usr/bin/env fish
    normal!o
endfunction