vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { guibg = NONE, ctermbg = NONE })
	end,
	desc = "Set background to transparent",
})
vim.cmd.colorscheme("catppuccin")

require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},

	integrations = {
		native_lsp = {
			enabled = true,
			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
			},
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		telescope = true,
		treesitter = true,
		fidget = true,
		gitsigns = true,
		cmp = true,
	},
})
