" Jeff VanDyke's init.vim

set tabstop=4
set shiftwidth=4
set expandtab

set mouse=a

" autoload changes
set autoread
au FocusGained,BufEnter * :silent! !
" save on focus lost
au FocusLost,BufLeave * :silent! w

" ---- digraphs ----------------------------------------------------------------
"digraphs use decimal encoding

dig y^ 375

" ---- vim-plug plugins --------------------------------------------------------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" ---- Single-file editing tools -------

" Detect tab/space indentation
Plug 'tpope/vim-sleuth'
" Fix stupid trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" ---- Multi-file level tools ----------

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = 'node_modules\|.git$\|\.o$'

Plug 'scrooloose/nerdtree'
" Open NERDTree in the directory of the current file (or /home if no file is open)
nmap <silent> <C-n> :call NERDTreeToggleInCurDir()<cr>
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
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

Plug 'mileszs/ack.vim'
let g:ackprg = 'rg --vimgrep'

" ---- Language-intelligent tools ------

" Tags management
Plug 'ludovicchabant/vim-gutentags'

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

call plug#end()
