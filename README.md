# Sennvim

Sennvim is a simple and lightweight vim configuration for Python, Go, and TypeScript development.

## Setup

### Requirements

This neovim configuration uses these packages under the hood. Install with homebrew:

```bash
brew install lazygit fzf ripgrep regex yazi
```

Or use your preferred package manager.

#### Python

The Python LSP setup uses a Ruff config. You can grab my config [here](https://github.com/ionztorm/dotfiles/blob/main/ruff/ruff.toml). 
Put it in `~/.config/ruff`. If you store it elsewhere, remember to update `lua/config/lauguages/python.lua`.

### Installation

Make a backup of your current nvim configuration, just in case you want to go back later. Once backed up,
delete them. The default directories are:

```text
~/.config/nvim
~/.local/share/nvim
~/.local/state/nvim
~/.cache/nvim
```

Now clone this repository into your nvim directory:

```bash
git clone https://github.com/ionztorm/sennvim.git ~/.config/nvim
```

Next, remove the git dir. You can keep plugins updated via the `:Lazy` command within neovim.

```bash
rm -rf ~/.config/nvim/.git .gitignore
```

Run nvim.

### Full Dev Environment

If you want to check out my full dev environment, my [dotfiles](https://www.github.com/ionztorm/dotfiles) are public.
I cover a setup guide for Mac [here](https://github.com/ionztorm/setups/blob/main/macos-fresh-setup.md)

## Plugins Included

Sennvim uses the following plugins:

- [Lazy.nvim](https://www.github.com/folke/lazy.nvim) - for plugin management.
- [LSP Config](https://www.github.com/neovim/nvim-lspconfig) - for language server protocol.
- [Mason](http://www.github.com/williamboman/mason.nvim) - for lsp/formatter/linter management.
- [Mason LSP Config](http://www.github.com/williamboman/mason-lspconfig.nvim) - for lsp/formatter/linter management.
- [Conform](http://www.github.com/stevearc/conform.nvim) - For auto formatting.
- [nvim lint](http://www.github.com/mfussenegger/nvim-lint) - for linting.
- [Blink CMP](https://www.github.com/Saghen/blink.cmp) - for autocompletion.
- [Copilot](https://www.github.com/zbirenbaum/copilot.lua) - AI Assistant - will need some custom work to change this.
- [Treesitter](https://www.github.com/nvim-treesitter/nvim-treesitter) - for syntax highlighting.
- [Gitsigns](https://www.github.com/lewis6991/gitsigns.nvim) - for git integration.
- [Snacks](https://www.github.com/folke/snacks.nvim) - Various, including LazyGit
- [TeleScope](https://www.github.com/nvim-telescope/telescope.nvim) - for fuzzy finder.
- [Trouble](https://www.github.com/folke/trouble.nvim) - for quickfix list.
- [Todo Comments](https://www.github.com/folke/todo-comments.nvim) - for todo comments colouring and highlights.
- [Mini.nvim](https://www.github.com/echasnovski/mini.nvim) - for statusline, autotags, icons, colour highlights, indent scope, cursorword, pairs
- [Colorizer](https://www.github.com/NvChad/nvim-colorizer.lua) - for colouring tailwind colours.
- [TS Autotag](https://www.github.com/windwp/nvim-ts-autotag) - for autotags in html and jsx.
- [Live Preview](https://www.github.com/brianhuster/live-preview.nvim) - for live preview of markdown and html files.
- [Yazi](https://github.com/mikavilpas/yazi.nvim?tab=readme-ov-file) - Yazi for neovim. Requires Yazi

## Language Servers

I've included a custom, modular approach to loading lagnuage servers, formatters, and linters into lsp config, conform, and nvim lint. To add your own languages, simply:

1. Create a new lua file for the language in `nvim/lua/config/languages`
2. Each language file should return a function.
3. In the function, call these globals:
  * `sennvim.lsp.add_config` to add an lsp server and config
  * `sennvim.formatters.add_formatter` to add a formatter
  * `sennvim.linters.add_linter` to add a linter.
4. These files will be automatically detected, loaded, and installed via Mason on the next load.

The signature for `lsp.add_config` is:

```lua
-- server_name: string
-- config: table
sennvim.lsp.add_config(server_name, config)
```

Signatures for linters and formatters are:

```lua
-- language: string
-- linters / formatter : table
sennvim.linters.add_linter(language, linters)
sennvim.formatters.add_formatter(language, formatter)
```

Linter and Formatter tables can contain multiple linters and formatters.

For example, here is the Python language file:

```lua

return function()
	sennvim.lsp.add_config("basedpyright", {
		settings = {
			basedpyright = {
				typeCheckingMode = "basic",
				autoImportCompletions = true,
				disableOrganizeImports = true,
			},
		},
	})
	sennvim.lsp.add_config("ruff", {
		init_options = {
			settings = {
				configuration = "~/.config/ruff/ruff.toml",
				logLevel = "debug",
			},
		},
	})
end
```

or TypeScript:

```lua
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

	local ts_settings = {
		settings = {
			maxTsServerMemory = 12288,
			typescript = {
				inlayHints = inlay_hints,
			},
			javascript = {
				inlayHints = inlay_hints,
			},
		},
	}

	sennvim.lsp.add_config("ts_ls", ts_settings)

	sennvim.formatters.add_formatter("typescript", { "biome" })
	sennvim.formatters.add_formatter("typescriptreact", { "biome" })
	sennvim.formatters.add_formatter("javascript", { "biome" })
	sennvim.formatters.add_formatter("javascriptreact", { "biome" })

	sennvim.formatters.add_formatter_config("biome", { prepend_args = { "check", "--unsafe", "--write" } })

	sennvim.linters.add_linter("typescript", { "biome", "eslint_d" })
	sennvim.linters.add_linter("javascrypt", { "biome", "eslint_d" })
	sennvim.linters.add_linter("typescriptreact", { "biome", "eslint_d" })
	sennvim.linters.add_linter("javacriptreact", { "biome", "eslint_d" })
end
```

Note: there is also a global `sennvim.formatters.add_formatter_config` available if you need to add additional args to the format command. You can see this in use in the TypeScript example above.

## Keybindings
### General

- `shift + up`/`shift + down` - Move selected text up and down.

### Buffers

- `leader bn` Switch to next buffer.
- `leader bp` Switch to previous buffer.
- `leader bd` Close all buffers apart from the current buffer.
- `leader bx` Close the current buffer.

### Quick access to tools

- `leader gg` Open Lazygit. Press `?` for help and keybindings.
- `leader ls` Toggle live preview for markdown and html files.
- `leader ee` Open Yazy. Yazi keybindings. See [Yazi Documentation](https://yazi-rs.github.io/docs/configuration/keymap)
- `leader ff` Open fuzzy finder
- `leader xx` Open diagnostics list
- `leader fg` Open live grep
- `leader fb` Open currently opened buffers.
- `leader fh` Search help files.
- `leader fx` Search in nvim config files for quick adjustments.

### LSP

- `leader cd` Go to code definition.
- `leader ch` View hover info ("K" also works).
- `leader ci` Go to implementation.
- `leader cr` Show references.
- `leader cn` Rename symbol under cursor.
- `leader ca` View code actions
- `leader cf` Format current file
- `leader ce` Open diagnostics list

## Still todo:

- Include dap & dap loaders.

## Contributing

I welcome the idea that someone might find this useful and want to contribute. If you have any ideas, suggestions, or improvements, please feel free to open an issue or a pull request.
