" Jeff VanDyke's init.vim

" Plugins first for vim-neovim-defaults
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

if !has('nvim')
  Plug 'noahfrederick/vim-neovim-defaults'
endif

map <space> <leader>

set backupdir-=.
set backupdir^=~/tmp,/tmp
" git gutter uses this for git refreshes
set updatetime=1000
" Disabling - not in work init.vim
" set backupcopy=yes
" " Required for operations modifying multiple buffers like rename.
" set hidden

" tab settings could be overridden by vim-sleuth per project
set tabstop=4
set shiftwidth=4
set expandtab

set number
set scrolloff=2
set mouse=a

if has('nvim')
  " show live preview of :s command
  set inccommand=nosplit
endif

nmap <leader>f :Ack<space>

" autoload changes
set autoread
au FocusGained,BufEnter * :silent! !
" save on focus lost
au FocusLost,BufLeave * :silent! update
set autowriteall

nmap ZW :w<cr>

" Auto-resize windows when host window is resized
autocmd VimResized * wincmd =

set noswapfile

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

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
" nnoremap <silent> <M-\> :TmuxNavigatePrevious<cr>

" ---- General Tools -------------------

Plug 'tpope/vim-unimpaired'

" ---- Multi-file level tools ----------

" Depends on fzf being installed
Plug '/usr/share/vim/vimfiles'
Plug 'junegunn/fzf.vim'
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

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

" " Detect tab/space indentation
" Plug 'tpope/vim-sleuth'

Plug 'editorconfig/editorconfig-vim'

" C++ switching between header and source
Plug 'vim-scripts/a.vim'
nmap <C-h> :A<CR>

" Fix stupid trailing whitespace
" old-plugin: Plug 'bronson/vim-trailing-whitespace'
Plug 'ntpeters/vim-better-whitespace'

Plug 'tpope/vim-surround'
" Allow vim-surround to use '.' for commands
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-commentary'

Plug 'easymotion/vim-easymotion'
" nmap <Tab> <Plug>(easymotion-prefix)
" vmap <Tab> <Plug>(easymotion-prefix)
" omap <Tab> <Plug>(easymotion-prefix)

" ---- Language-intelligent tools ------

" Tags management
Plug 'ludovicchabant/vim-gutentags'
" TODO: set project root and excludes as needed per project type
nmap <C-]> g<C-]>

Plug 'majutsushi/tagbar'
map <C-b> :TagbarToggle<cr>

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" \ 'c': ['clangd'],
" \ 'javascript': ['flow-language-server', '--stdio'],
" \ 'javascript.jsx': ['flow-language-server', '--stdio'],
" \ 'javascript': ['flow', 'lsp', '--from', './node_modules/.bin'],
" \ 'javascript.jsx': ['flow', 'lsp', '--from', './node_modules/.bin'],
" \ 'javascript': ['javascript-typescript-stdio'],
" \ 'javascript.jsx': ['javascript-typescript-stdio'],
let g:LanguageClient_serverCommands = {
    \ 'c': ['/usr/bin/cquery',
    \   '--log-file=/tmp/cq.log',
    \   '--init={"cacheDirectory":"/var/cquery/"}'],
    \ 'cpp': ['/usr/bin/cquery',
    \   '--log-file=/tmp/cq.log',
    \   '--init={"cacheDirectory":"/var/cquery/"}'],
    \ 'rust': ['rls'],
    \ 'javascript': ['flow-language-server', '--stdio', '--try-flow-bin'],
    \ 'javascript.jsx': ['flow-language-server', '--stdio', '--try-flow-bin'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ }
" let g:LanguageClient_autoStart = 1 (1 by default anyway)
let g:LanguageClient_rootMarkers = {
    \ 'javascript': ['.flowconfig', 'package.json'],
    \ 'javascript.jsx': ['.flowconfig', 'package.json'],
    \ }
let g:LanguageClient_diagnosticsList = "Location"
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" linter
Plug 'w0rp/ale'
let g:ale_fixers = {
      \   'javascript': ['eslint'],
      \   'javascript.jsx': ['eslint'],
      \}
let g:ale_linters = {
    \ 'rust': [],
    \ 'cpp': [],
    \}
"\   'cpp': ['clang', 'cppcheck', 'gcc', 'clang-format'],
let g:ale_cpp_clangtidy_header_suffixes = ['h', 'hpp', 'hxx', 'tcc']
let g:ale_javascript_eslint_executable='eslint_d'
let g:ale_completion_enabled = 0
let g:ale_set_loclist = 0 " I like to use the location list for other things
let g:ale_set_quickfix = 0

nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" see deoplete's README.md
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  " Neovim compatibility provided as first 2 plugins
endif
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_at_startup = 1

" Uses clang-format to format code with Vim
Plug 'rhysd/vim-clang-format'

Plug 'sheerun/vim-polyglot'
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 1 " Allow JSX in normal JS files

call plug#end()

" settings for Solarized colorscheme
set termguicolors
set background=dark
colorscheme solarized8
