" Jeff VanDyke's init.vim

" Plugins first for vim-neovim-defaults
" vim-plug auto-install method, works for NeoVim and Vim both.
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

" gitgutter uses this for git refreshes
set updatetime=400

" tab settings could be overridden by .editorconfig or vim-sleuth per project
set tabstop=4
set shiftwidth=4
set expandtab

set number
set relativenumber
au BufReadPost quickfix setlocal norelativenumber
set wrap
set linebreak
set showbreak=▶▶━┫

set scrolloff=2
set mouse=a

set cursorcolumn
set cursorline

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

" custom mappings
nmap ZW :w<cr>
nmap <leader>f :Ack<space>
" Joins paragraphs with "^A" control characters and resets them back.
nnoremap <Leader>[j :%s/\(.\+\)\n/\1/g<cr>:noh<cr>
vnoremap <Leader>[j  :s/\(.\+\)\n/\1/g<cr>:noh<cr>
nnoremap <Leader>]j :%s//\r/g<cr>
vnoremap <Leader>]j  :s//\r/g<cr>

" Auto-resize windows when host window is resized
:autocmd VimResized * wincmd =

" C++ indentation
set cinoptions=g0

" Javascript path navigation
set path=.,src
set suffixesadd=.js,.jsx,/index.js,/index.jsx

"" function! LoadMainNodeModule(fname)
""     let nodeModules = "./node_modules/"
""     let packageJsonPath = nodeModules . a:fname . "/package.json"
""
""     if filereadable(packageJsonPath)
""         return nodeModules . a:fname . "/" . json_decode(join(readfile(packageJsonPath))).main
""     else
""         return nodeModules . a:fname
""     endif
"" endfunction
""
"" set includeexpr=LoadMainNodeModule(v:fname)

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

" casing smarts for renaming
Plug 'tpope/vim-abolish'

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

Plug 'ap/vim-css-color'

" Fix stupid trailing whitespace
" old-plugin: Plug 'bronson/vim-trailing-whitespace'
Plug 'ntpeters/vim-better-whitespace'

Plug 'tpope/vim-surround'
" Allow vim-surround to use '.' for commands
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-commentary'

Plug 'easymotion/vim-easymotion'
" Can't use tab - it's ctrl-i, just the way it works.
" nmap <Tab> <Plug>(easymotion-prefix)
" vmap <Tab> <Plug>(easymotion-prefix)
" omap <Tab> <Plug>(easymotion-prefix)

" ---- Language-intelligent tools ------

" Tags management
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_exclude = ['*node_modules*', 'assets/webhelp/*', '*buildroot/output/*', '*client/build/*']
let g:gutentags_project_root = ['package.json']
nmap <C-]> g<C-]>

Plug 'majutsushi/tagbar'
command! TT TagbarToggle

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" \ 'javascript': ['npx', 'flow', 'lsp'],
" \ 'javascript.jsx': ['npx', 'flow', 'lsp'],
" \ 'javascriptreact': ['npx', 'flow', 'lsp'],
" \ 'typescript': ['javascript-typescript-stdio'],
" \ 'cs': ['mono',
" \   '/opt/omnisharp-roslyn/OmniSharp.exe',
" \   '--languageserver',
" \   '--verbose'],
let g:LanguageClient_serverCommands = {
    \ 'c': ['/usr/bin/cquery',
    \   '--log-file=/tmp/cq.log',
    \   '--init={"cacheDirectory":"/var/cquery/"}'],
    \ 'cpp': ['/usr/bin/cquery',
    \   '--log-file=/tmp/cq.log',
    \   '--init={"cacheDirectory":"/var/cquery/"}'],
    \ 'rust': ['rls'],
    \ 'javascript': ['npx', 'typescript-language-server', '--stdio'],
    \ 'javascript.jsx': ['npx', 'typescript-language-server', '--stdio'],
    \ 'javascriptreact': ['npx', 'typescript-language-server', '--stdio'],
    \ 'typescript': ['npx', 'typescript-language-server', '--stdio'],
    \ 'typescript.tsx': ['npx', 'typescript-language-server', '--stdio'],
    \ }
" let g:LanguageClient_autoStart = 1 (1 by default anyway)
let g:LanguageClient_rootMarkers = {
    \ 'cs': ['.git', '*.csproj'],
    \ 'javascript': ['package.json', '.git'],
    \ 'javascript.jsx': ['package.json', '.git'],
    \ 'javascriptreact': ['package.json', '.git'],
    \ 'typescript': ['package.json', '.git'],
    \ 'typescript.tsx': ['package.json', '.git'],
    \ }
let g:LanguageClient_diagnosticsList = "Location"
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
inoremap <F5> :call LanguageClient_contextMenu()<CR>
vnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" lots of leader commands
nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>

" set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()<CR>
let g:LanguageClient_useVirtualText = 0
let g:LanguageClient_hoverPreview = "Always"

" for debugging
" let g:LanguageClient_loggingLevel = 'DEBUG'
" let g:LanguageClient_loggingFile = 'lang-client.log'

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
" \ 'cs': ['OmniSharp'],
"\   'cpp': ['clang', 'cppcheck', 'gcc', 'clang-format'],
let g:ale_cpp_clangtidy_header_suffixes = ['h', 'hpp', 'hxx', 'tcc']
let g:ale_javascript_eslint_executable='eslint_d'
let g:ale_completion_enabled = 0
let g:ale_set_loclist = 0 " I like to use the location list for other things
let g:ale_set_quickfix = 0
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

set completeopt=menuone,preview,longest

" see deoplete's README.md
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  " Neovim compatibility provided as first 2 plugins
endif
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_at_startup = 1

"" Plug 'OmniSharp/omnisharp-vim'
"" let g:OmniSharp_timeout = 5
"" set completeopt=longest,menuone,preview
"" augroup omnisharp_commands
""     autocmd!
""     " DISABLE - idonlikit
""     " " Show type information automatically when the cursor stops moving
""     " autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
""     " The following commands are contextual, based on the cursor position.
""     autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
""     autocmd FileType cs nnoremap <buffer> <Leader>sfi :OmniSharpFindImplementations<CR>
""     autocmd FileType cs nnoremap <buffer> <Leader>sfs :OmniSharpFindSymbol<CR>
""     autocmd FileType cs nnoremap <buffer> <Leader>sfu :OmniSharpFindUsages<CR>
""     " Finds members in the current buffer
""     autocmd FileType cs nnoremap <buffer> <Leader>sfm :OmniSharpFindMembers<CR>
""     autocmd FileType cs nnoremap <buffer> <Leader>sfx :OmniSharpFixUsings<CR>
""     autocmd FileType cs nnoremap <buffer> <Leader>stt :OmniSharpTypeLookup<CR>
""     autocmd FileType cs nnoremap <buffer> <Leader>sdc :OmniSharpDocumentation<CR>
""     autocmd FileType cs nnoremap <buffer> K :OmniSharpDocumentation<CR>
""     autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
""     autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>
""     " Navigate up and down by method/property/field
""     autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
""     autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
"" augroup END
"" " Add syntax highlighting for types and interfaces
"" nnoremap <Leader>sht :OmniSharpHighlightTypes<CR>

Plug 'maksimr/vim-jsbeautify'

" DISABLE lsp+cquery autocomplete good enough Plug 'zchee/deoplete-clang'
" DISABLE lsp+cquery autocomplete good enough let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
" DISABLE lsp+cquery autocomplete good enough let g:deoplete#sources#clang#clang_header='/usr/lib/clang'

" Uses clang-format to format code with Vim
Plug 'rhysd/vim-clang-format'
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :%ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
nmap <Leader>C :ClangFormatAutoToggle<CR>

" au BufNewFile,BufRead *.xaml        setf xml

Plug 'sheerun/vim-polyglot'
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 1 " Don't mix JSX in normal JS files, needed for Flow
au BufRead,BufNewFile,BufReadPost *.js.flow set filetype=javascript

Plug 'jparise/vim-graphql'

Plug 'ledger/vim-ledger'
" config link: https://github.com/ledger/vim-ledger
nmap <Leader>ln :%LedgerAlign<cr>
nmap <Leader>le :call ledger#entry()<cr>

call plug#end()

" settings for Solarized colorscheme
set termguicolors
set background=dark
colorscheme solarized8
