local M = {}

-- Table to store LSP servers
M.servers = {}
M.formatters = {}


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

-- Function to register an LSP server
M.register_server = function(server_name, config)
    config.capabilities = config.capabilities or capabilities
    M.servers[server_name] = config
end

-- Function to register a formatter
M.register_formatter = function(language, formatter)
    M.formatters[language] = formatter
end

-- Function to setup LSP servers
M.setup = function()
    local lspconfig = require('lspconfig')

    for server, config in pairs(M.servers) do
        lspconfig[server].setup(config)
    end
end

-- Function to get the list of registered servers
M.get_servers = function()
    return vim.tbl_keys(M.servers)  -- Return the list of server names
end

-- get the formatters table
M.get_formatters = function()
    return M.formatters
end

-- Function to get the list of all registered servers and formatters
M.get_all_servers_and_formatters = function()
    local combined_list = {}

    -- Add LSP server names
    for server_name, _ in pairs(M.servers) do
        table.insert(combined_list, server_name)
    end

    -- Add formatter names (from the registered formatters)
    for _, formatters in pairs(M.formatters) do
        for _, formatter in ipairs(formatters) do
            table.insert(combined_list, formatter)
        end
    end

    return combined_list
end

-- Automatically load all language-specific configurations
local function load_language_configs()
    local configs = {
        'plugins.lspconfigs.langs.typescript',
        'plugins.lspconfigs.langs.lua',
        'plugins.lspconfigs.langs.go',
        -- 'plugins.lspconfigs.python',
        -- Add other language modules here
    }

    for _, module in ipairs(configs) do
        local ok, lang_config = pcall(require, module)
        if ok and type(lang_config) == "function" then
            lang_config(M)
        else
            print("Error loading config:", module)
        end
    end
end

load_language_configs()

return M

