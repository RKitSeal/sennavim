return function(lsp)
    lsp.register_server('ts_ls', {
        on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        end,
    })

    lsp.register_formatter('typescript', { 'biome' })
    lsp.register_formatter('typescriptreact', { 'biome' })
    lsp.register_formatter('javascript', { 'biome' })
    lsp.register_formatter('javascriptreact', { 'biome' })
end

