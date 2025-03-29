return {
	{
		"ggml-org/llama.vim",
		init = function()
			vim.g.llama_config = {
				auto_fim = true,
			}
		end,
	},
}
