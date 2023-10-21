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

" let g:clipboard = 'xclip'

set nohidden

command Bd :up | %bd | e#

let g:netrw_liststyle = 3  " Use tree view
" let g:netrw_winsize = '30' " Smaller default window size
let g:netrw_altv = '1'

" gitgutter uses this for git refreshes
set updatetime=400

" tab settings could be overridden by .editorconfig or vim-sleuth per project
set tabstop=4
set shiftwidth=4
set expandtab

set number
" set relativenumber
au BufReadPost quickfix setlocal norelativenumber
set wrap
set linebreak
set showbreak=▶▶━┫

set scrolloff=2
set mouse=a

set cursorcolumn
set cursorline

set shortmess+=c

" From COC recommendations
set cmdheight=2

" From COC recommendations
set nobackup
set nowritebackup

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
nmap <leader>f :Ack!<space>
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

" ---- Vim 8 - Neovim compatibility ----

if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" ---- Global settings -----------------

Plug 'morhetz/gruvbox'
autocmd vimenter * ++nested colorscheme gruvbox

" Plug 'lifepillar/vim-solarized8'
" " settings below plug#end

Plug 'mbbill/undotree'
nnoremap <F5> :UndotreeToggle<CR>

Plug 'vim-airline/vim-airline'
" let g:airline_section_a = airline#section#create(['mode'])
let g:airline_section_b = ''
let g:airline_section_y = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''
" let g:airline#extensions#branch#displayed_head_limit = 15
" let g:airline#extensions#branch#format = 2

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
nmap [of :setlocal foldmethod=syntax<cr>
nmap ]of :setlocal foldmethod=manual<cr>
nmap [oa :ALEEnable<cr>
nmap ]oa :ALEDisable<cr>


" casing smarts for renaming
Plug 'tpope/vim-abolish'

Plug 'AndrewRadev/linediff.vim'
vmap <leader>dl :Linediff<cr>
nmap <leader>dr :LinediffReset<cr>

" ---- Multi-file level tools ----------

" Depends on fzf being installed
" Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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
Plug 'tpope/vim-rhubarb'

Plug 'airblade/vim-gitgutter'
let g:gitgutter_diff_args = '-M'
command! -nargs=1 Gbase let g:gitgutter_diff_base = '<args>'
command! Gnobase let g:gitgutter_diff_base = ''

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

Plug 'chrisbra/csv.vim'

Plug 'pantharshit00/vim-prisma'

" Plug 'easymotion/vim-easymotion'
" Can't use tab - it's ctrl-i, just the way it works.
" nmap <Tab> <Plug>(easymotion-prefix)
" vmap <Tab> <Plug>(easymotion-prefix)
" omap <Tab> <Plug>(easymotion-prefix)

" ---- Language-intelligent tools ------

" Tags management
" Plug 'ludovicchabant/vim-gutentags'
" let g:gutentags_ctags_exclude = ['*node_modules*', 'assets/webhelp/*', '*buildroot/output/*', '*client/build/*']
" let g:gutentags_project_root = ['package.json']
" nmap <C-]> g<C-]>

Plug 'majutsushi/tagbar'
command! TT TagbarToggle

" Plug 'Quramy/tsuquyomi'

" Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
" let g:nvim_typescript#type_info_on_hold = 1

augroup typescript_bindings
  autocmd!
  autocmd FileType javascript call s:setup_ts_bundings()
  autocmd FileType javascriptreact call s:setup_ts_bundings()
  autocmd FileType typescript call s:setup_ts_bundings()
  autocmd FileType typescriptreact call s:setup_ts_bundings()
  function! s:setup_ts_bundings() abort
    set signcolumn=yes
  endfunction
augroup end

Plug 'maksimr/vim-jsbeautify'

" Allow comments in json
Plug 'neoclide/jsonc.vim'

" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

" " Uses clang-format to format code with Vim
" Plug 'rhysd/vim-clang-format'
" autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :%ClangFormat<CR>
" autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" nmap <Leader>C :ClangFormatAutoToggle<CR>

" au BufNewFile,BufRead *.xaml        setf xml

Plug 'sheerun/vim-polyglot'
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 1 " Don't mix JSX in normal JS files, needed for Flow
au BufRead,BufNewFile,BufReadPost *.js.flow set filetype=javascript

Plug 'jparise/vim-graphql'

Plug 'ledger/vim-ledger'
" config link: https://github.com/ledger/vim-ledger
augroup ledger
  autocmd!
  let g:ledger_align_at=50
  autocmd FileType ledger nmap <Leader>lf :%LedgerAlign<cr>
  autocmd FileType ledger nmap <Leader>le :call ledger#entry()<cr>
  " autocmd FileType ledger nmap <Leader>le :.! xargs ledger xact<cr>
augroup end
nmap <Leader>[c :call ledger#transaction_post_state_set(line('.'), '*')<cr>
nmap <Leader>]c :call ledger#transaction_post_state_set(line('.'), ' ')<cr>

call plug#end()

" settings for colorscheme
set termguicolors
set background=light
" colorscheme solarized8

" Manual options
" call deoplete#custom#option('auto_complete', v:false)

