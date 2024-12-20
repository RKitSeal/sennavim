return function(lsp)
    lsp.register_server('lua_ls', {})
    lsp.register_formatter('lua', { 'stylua' })
end
