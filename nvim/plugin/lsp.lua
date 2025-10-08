local on_attach = function(_, bufnr)
	local bufmap = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	bufmap("<leader>rn", vim.lsp.buf.rename, "Rename")
	bufmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
	bufmap("<leader>td", vim.lsp.buf.type_definition, "Type Definition")

	bufmap("gd", vim.lsp.buf.definition, "Goto Definition")
	bufmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
	bufmap("gr", require("telescope.builtin").lsp_references, "Goto References")
	bufmap("gI", vim.lsp.buf.implementation, "Goto Implementation")

	bufmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
	bufmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

	bufmap("K", vim.lsp.buf.hover, "Hover Documentation")
	bufmap("<M-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	bufmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
	bufmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
	bufmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "Workspace List Folders")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("neodev").setup()
vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
	on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.enable("nil_ls")
vim.lsp.config("nil_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.enable("bashls")
vim.lsp.config("bashls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.enable("cssls")
vim.lsp.config("cssls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.enable("ts_ls")
vim.lsp.config("ts_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.enable("jdtls")
vim.lsp.config("jdtls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.enable("rust_analyzer")
vim.lsp.config("rust_analyzer", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.enable("vala_ls")
vim.lsp.config("vala_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
})
