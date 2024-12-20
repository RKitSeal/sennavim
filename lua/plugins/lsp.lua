return {
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "Saghen/blink.cmp",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local mason_tool_installer = require("mason-tool-installer")
            local lsp_setup = require("plugins.lspconfigs.lsp-setup")
            local servers = lsp_setup.get_servers()
            local servers_and_formatters = lsp_setup.get_all_servers_and_formatters()

            lsp_setup.setup()

            mason.setup({
                ui = {
                    border = "rounded",
                },
            })

            mason_lspconfig.setup({
                ensure_installed = servers,
            })

            mason_tool_installer.setup({
                auto_update = true,
                run_on_start = true,
                start_delay = 3000,
                debounce_hours = 12,
                ensure_installed = servers_and_formatters,
            })
        end,
    },
    {
        'stevearc/conform.nvim',
        event = { "BufWritePre" },
        cmd = { "ConfosmInfo" },
        opts = {
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            default_format_opts = {
                async = true,
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters_by_ft = require('plugins.lspconfigs.lsp-setup').get_formatters(),
        },
    },
}
