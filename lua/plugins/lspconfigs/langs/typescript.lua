return function(lsp)
    local inlay_hints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,

    }

    lsp.register_server('ts_ls', {
        settings = {
            maxTsServerMemory = 12288,
            typescript = {
                inlayHints = inlay_hints,
            },
            javascript = {
                inlayHints = inlay_hints,
            },
        },
    })

    lsp.register_formatter('typescript', { 'biome' })
    lsp.register_formatter('typescriptreact', { 'biome' })
    lsp.register_formatter('javascript', { 'biome' })
    lsp.register_formatter('javascriptreact', { 'biome' })
end
