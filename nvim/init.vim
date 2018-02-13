" Jeff VanDyke's init.vim

set tabstop=4
set shiftwidth=4
set expandtab

set mouse=a

" show live preview of :s command
set inccommand=nosplit

"terminal-input
tnoremap <Esc> <C-\><C-n>

" autoload changes
set autoread
au FocusGained,BufEnter * :silent! !
" save on focus lost
au FocusLost,BufLeave * :silent! w
set autowriteall

" Auto-resize windows when host window is resized
autocmd VimResized * wincmd =

" ---- digraphs ----------------------------------------------------------------
"digraphs use decimal encoding
dig y^ 375

" ---- vim-plug plugins --------------------------------------------------------

if has("nvim")
  let plugPath = "~/.local/share/nvim/plugged"
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
else
  let plugPath = "~/.vim/plugged"
  if empty(glob('~/.vim/autoload/plug.vim'))
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

call plug#begin(plugPath)

" ---- Global settings -----------------

Plug 'lifepillar/vim-solarized8'
" settings below plug#end

" ---- General Tools -------------------

Plug 'tpope/vim-unimpaired'

" ---- Multi-file level tools ----------

" try fzf " Plug 'ctrlpvim/ctrlp.vim'
" try fzf " let g:ctrlp_custom_ignore = 'node_modules\|.git$\|\.o$'
" try fzf " function! SilentUpdate()
" try fzf "   exe ":silent! update"
" try fzf " endfunction
" try fzf " let g:ctrlp_buffer_func = {
" try fzf "       \ 'enter': 'SilentUpdate',
" try fzf "       \ }
" try fzf " nmap <silent> <C-p> :silent! update<cr>:CtrlP<cr>

" Depends on fzf being installed
Plug '/usr/share/vim/vimfiles'
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree'
" Open NERDTree in the directory of the current file (or /home if no file is open)
nmap <silent> <C-n> :call NERDTreeToggleInCurDir()<cr>
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("b:NERDTree"))
    exe ":NERDTreeClose"
  elseif bufname('%') != ''
    exe ":NERDTreeFind"
  else
    exe ":NERDTree"
  endif
endfunction
" close vi if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tpope/vim-fugitive'

Plug 'mileszs/ack.vim'
let g:ackprg = 'rg --vimgrep'

" ---- Single-file editing tools -------

" Detect tab/space indentation
Plug 'tpope/vim-sleuth'

" Fix stupid trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

Plug 'tpope/vim-surround'
" Allow vim-surround to use '.' for commands
Plug 'tpope/vim-repeat'

" ---- Language-intelligent tools ------

" Tags management
Plug 'ludovicchabant/vim-gutentags'
nmap <C-]> g<C-]>

Plug 'majutsushi/tagbar'
map <C-b> :TagbarToggle<cr>

" linter
Plug 'w0rp/ale'
let g:ale_fixers = {
      \   'javascript': ['eslint'],
      \}
let g:ale_javascript_eslint_executable='eslint_d'
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" deoplete backend for javascript
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#types = 1

" improve javascript highlighting and syntax support
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1

" detect jsx and be smart about it, works with vim-javascript, I think.
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

call plug#end()

" settings for Solarized colorscheme
set termguicolors
set background=dark
colorscheme solarized8
