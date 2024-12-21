return function()
    sennvim.lsp.add_config('lua_ls', {
        ettings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                workspace = {
                    checkThirdParty = false,
                    -- Tells lua_ls where to find all the Lua files that you have loaded
                    -- for your neovim configuration.
                    library = {
                        "${3rd}/luv/library",
                        unpack(vim.api.nvim_get_runtime_file("", true)),
                    },
                },
                telemetry = { enabled = false },
            },
        },
    })

    sennvim.formatters.add_formatter('lua', { 'stylua' })
end
