-- auto wrap text at 80 characters for markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "md" },
	callback = function()
		-- Enable line wrapping
		vim.opt_local.wrap = true
		-- Set text width to 80 characters for soft wrapping
		vim.opt_local.textwidth = 80
		-- Ensure linebreak is enabled to respect showbreak for manual line breaks
		vim.opt_local.linebreak = true
		-- Set the character for showing at the beginning of hard-wrapped lines
		vim.opt_local.showbreak = "↪ "
		-- Enable indentation for wrapped lines (soft wrapping)
		vim.opt_local.breakindent = true
		-- Optional: Adjust breakindent for better visual alignment (e.g., 2 spaces)
		vim.opt_local.breakindentopt = "shift:2"
	end,
})
