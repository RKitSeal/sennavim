return function(lsp)
    lsp.register_server('gopls', {
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                    unreachable = true,
                },
                staticcheck = true,
                usePlaceholders = true,
                completeUnimported = true,
            },
        },
    })

    lsp.register_formatter('go', { 'gopls' })
end
