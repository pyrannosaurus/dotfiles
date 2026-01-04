-- 1. Source the Vimscript settings
local config_path = vim.fn.stdpath('config')
local vimrc_file = config_path .. '/vimrc.vim'
if vim.fn.filereadable(vimrc_file) == 1 then
    vim.cmd('source ' .. vimrc_file)
end
local vim_local = config_path .. '/.vim_local'
if vim.fn.filereadable(vim_local) == 1 then
    vim.cmd('source ' .. vim_local)
end

-- 2. Native LSP Configuration (Neovim 0.11+)
if vim.lsp.enable then
    vim.lsp.enable('pyright')
    vim.lsp.enable('ts_ls')
    -- vim.lsp.config('perlls', {
    --     cmd = {"/usr/bin/perl", "-MPerl::LanguageServer", "-e", "Perl::LanguageServer::run"}
    -- })
    -- vim.lsp.enable('perlls')
end

-- 3. LSP Keybindings & Behavior
-- This only attaches these maps when an LSP is actually active in a buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    end,
})

-- 4. LSP Document Highlighting (Cursor Hold)
vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
    group = "LspDocumentHighlight",
    callback = vim.lsp.buf.document_highlight,
})
vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
    group = "LspDocumentHighlight",
    callback = vim.lsp.buf.clear_references,
})

-- 5. Plugin Configurations (Wrapped to prevent errors if not yet installed)
local ts_status, treesitter = pcall(require, 'nvim-treesitter.configs')
if ts_status then
    treesitter.setup {
        ensure_installed = { "python", "javascript", "typescript" },
        highlight = { enable = true },
        matchup = { enable = true }
    }
else
    print("Treesitter not found. Run :PlugInstall then restart.")
end

-- Surround Setup
local surround_status, surround = pcall(require, 'nvim-surround')
if surround_status then
    surround.setup()
end
