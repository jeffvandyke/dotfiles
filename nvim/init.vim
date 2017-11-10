" Jeff VanDyke's init.vim

set tabstop=4
set shiftwidth=4
set expandtab

" ---- vim-plug plugins --------------------------------------------------------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" much better stuff for javascript

Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1

" detect jsx and be smart about it, works with vim-javascript, I think.
Plug 'mxw/vim-jsx'

Plug 'tpope/vim-sleuth'

Plug 'w0rp/ale'
let g:ale_fixers = {
            \   'javascript': ['eslint'],
            \}

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = 'node_modules\|git'

Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
" close vi if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

" ---- end plugins -------------------------------------------------------------
