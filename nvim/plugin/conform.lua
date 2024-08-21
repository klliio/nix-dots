vim.keymap.set("n", "<leader>fb", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format Buffer" })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "nixfmt" },
		shell = { "shfmt" },
		javascript = { "prettierd" },
		java = { "prettierd" },
		css = { "prettierd" },
		scss = { "prettierd" },
	},
})
