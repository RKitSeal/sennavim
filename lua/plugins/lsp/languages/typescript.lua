return function()

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

    sennvim.lsp.add_config('ts_ls', {
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

    sennvim.formatters.add_formatter('typescript', { 'biome' })
    sennvim.formatters.add_formatter('typescriptreact', { 'biome' })
    sennvim.formatters.add_formatter('javascript', { 'biome' })
    sennvim.formatters.add_formatter('javascriptreact', { 'biome' })
    sennvim.formatters.add_formatter_config('biome',{ prepend_args = {"check", "--unsafe", "--write"}})
end
