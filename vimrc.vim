" --- General Settings ---
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set clipboard=unnamedplus
set incsearch
set ignorecase
set smartcase
set termguicolors
set splitbelow
set splitright
set updatetime=400

let g:python3_host_prog = '/usr/bin/python3'
let g:hubdir = getenv('hub')

" --- Plugins ---
call plug#begin('~/.config/nvim/plugged')
    Plug 'https://github.com/neovim/nvim-lspconfig.git'
    Plug 'https://github.com/hrsh7th/nvim-cmp.git'
    Plug 'https://github.com/hrsh7th/cmp-nvim-lsp.git'
    Plug 'https://github.com/L3MON4D3/LuaSnip.git'
    Plug 'https://github.com/tpope/vim-dadbod.git'
    Plug 'https://github.com/andymass/vim-matchup.git'
    Plug 'https://github.com/Chiel92/vim-autoformat.git'
    Plug 'https://github.com/morhetz/gruvbox.git'
    Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'https://github.com/navarasu/onedark.nvim.git'
    Plug 'https://github.com/kylechui/nvim-surround.git'
    Plug 'https://github.com/tpope/vim-fugitive.git'
call plug#end()

" --- Autoformat Config ---
let g:formatdef_prettier = '"prettier --stdin-filepath ".expand("%")'
let g:formatters_javascript = ['prettier']
let g:formatters_typescript = ['prettier']
let g:formatdef_sqlfluff = '"sqlfluff fix --dialect tsql --disable-progress-bar - - < <(cat)"'
let g:formatters_sql = ['sqlfluff']

augroup AutoFormatting
    autocmd!
    autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx Autoformat
    autocmd BufWritePre *.sql Autoformat
augroup END

" --- Look & Feel ---
colorscheme onedark
let g:python_highlight_all = 1
highlight @variable guifg=#96e3e2
highlight LspReferenceRead cterm=bold ctermbg=239 guibg=#393939
highlight LspReferenceText cterm=bold ctermbg=238 guibg=#444444
highlight LspReferenceWrite cterm=bold ctermbg=237 guibg=#404060

" --- Keybindings ---
let mapleader = " "
inoremap kj <esc>
vnoremap kj <esc>
nnoremap <leader>fm :Autoformat<CR>
vnoremap <leader>fm :Autoformat<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Git Bindings
nnoremap <leader>gs :Git<CR>
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>

command! -range=% Sqlfmt <line1>,<line2>!sqlfmt - 2>/dev/null
