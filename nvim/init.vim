" Jeff VanDyke's init.vim

set tabstop=4
set shiftwidth=4
set expandtab

set mouse=a

" autoload changes
set autoread

" ---- vim-plug plugins --------------------------------------------------------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Detect tab/space indentation
Plug 'tpope/vim-sleuth'

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = 'node_modules\|git'

Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
" close vi if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'Xuyuanp/nerdtree-git-plugin'

" Tags management
Plug 'ludovicchabant/vim-gutentags'

" linter
Plug 'w0rp/ale'
let g:ale_fixers = {
            \   'javascript': ['eslint'],
            \}
let g:ale_javascript_eslint_executable='eslint_d'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" deoplete backend for javascript
Plug 'carlitux/deoplete-ternjs'

" improve javascript highlighting and syntax support
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1

" detect jsx and be smart about it, works with vim-javascript, I think.
Plug 'mxw/vim-jsx'

call plug#end()
