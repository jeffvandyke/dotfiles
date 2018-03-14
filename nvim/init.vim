" Jeff VanDyke's init.vim

set backupdir-=.
set backupdir^=~/tmp,/tmp

" tab settings could be overridden by vim-sleuth per project
set tabstop=4
set shiftwidth=4
set expandtab

set number
set scrolloff=4
set mouse=a

if has('nvim')
  " show live preview of :s command
  set inccommand=nosplit
endif

" autoload changes
set autoread
au FocusGained,BufEnter * :silent! !
" save on focus lost
au FocusLost,BufLeave * :silent! update
set autowriteall

nmap ZW :w<cr>

" Auto-resize windows when host window is resized
autocmd VimResized * wincmd =

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

" ---- Vim 8 - Neovim compatibility ----

if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" ---- Global settings -----------------

Plug 'lifepillar/vim-solarized8'
" settings below plug#end

Plug 'vim-airline/vim-airline'
let g:airline_section_a = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#branch#format = 2


" ---- General Tools -------------------

Plug 'tpope/vim-unimpaired'

" ---- Multi-file level tools ----------

" Depends on fzf being installed
Plug '/usr/share/vim/vimfiles'
Plug 'junegunn/fzf.vim'

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" Custom map
nmap <C-p> :Files<cr>

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

Plug 'airblade/vim-gitgutter'

Plug 'mileszs/ack.vim'
let g:ackprg = 'rg --vimgrep'

" ---- Single-file editing tools -------

" Detect tab/space indentation
Plug 'tpope/vim-sleuth'

" C++ switching between header and source
Plug 'vim-scripts/a.vim'
nmap <C-h> :A<CR>

" Fix stupid trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

Plug 'tpope/vim-surround'
" Allow vim-surround to use '.' for commands
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-commentary'

Plug 'easymotion/vim-easymotion'
map <Leader>o <Plug>(easymotion-prefix)

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

" see deoplete's README.md
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  " Neovim compatibility provided as first 2 plugins
endif
let g:deoplet#enable_smart_case = 1
let g:deoplete#enable_at_startup = 1

" DISABLE " deoplete backend for javascript
" DISABLE Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" DISABLE let g:deoplete#sources#ternjs#docs = 1
" DISABLE let g:deoplete#sources#ternjs#depths = 1
" DISABLE let g:deoplete#sources#ternjs#types = 1

Plug 'zchee/deoplete-clang'
let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang'

" improve javascript highlighting and syntax support
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1

" detect jsx and be smart about it, works with vim-javascript, I think.
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" DISABLE Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

call plug#end()

" settings for Solarized colorscheme
set termguicolors
set background=dark
colorscheme solarized8
