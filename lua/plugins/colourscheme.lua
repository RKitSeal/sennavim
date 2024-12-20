return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            style = "night",
            transparent = true,
            terminal_colors = true,
            styles = {
                floats = "transparent",
                sidebars = "transparent",
                comments = { italic = false },
                keywords = { italic = false },
                variables = { bold = true },
            },
            dim_inactive = true,
        })
        vim.cmd.colorscheme("tokyonight")
    end,
}
