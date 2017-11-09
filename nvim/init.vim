" vim-plug

set tabstop=4
set shiftwidth=4
set expandtab

call plug#begin('~/.local/share/nvim/plugged')

Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1

Plug 'mxw/vim-jsx'

Plug 'tpope/vim-sleuth'

Plug 'w0rp/ale'
let g:ale_fixers = {
            \   'javascript': ['eslint'],
            \}

call plug#end()
