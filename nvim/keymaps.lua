-- navigation
vim.keymap.set({ "n" }, "<s-tab>", ":bp<CR>", { desc = "Move to the Previous Buffer" })
vim.keymap.set({ "n" }, "<tab>", ":bn<CR>", { desc = "Move to the Next Buffer" })
vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ "n" }, "<C-Up>", ":resize -1<CR>", { silent = true, remap = false, desc = "Shrink the Window Horizontally" })
vim.keymap.set({ "n" }, "<C-Down>", ":resize +1<CR>", { silent = true, remap = false, desc = "Grow the Window Horizontally" })
vim.keymap.set({ "n" }, "<C-Left>", ":vertical resize -1<CR>", { silent = true, remap = false, desc = "Shrink the Window Vertically" })
vim.keymap.set({ "n" }, "<C-Right>", ":vertical resize +1<CR>", { silent = true, remap = false, desc = "Grow the Window Vertically" })
vim.keymap.set({ "n" }, "<C-k>", ":wincmd k<CR>", { silent = false, remap = false, desc = "Move up a split" })
vim.keymap.set({ "n" }, "<C-j>", ":wincmd j<CR>", { silent = false, remap = false, desc = "Move down a split" })
vim.keymap.set({ "n" }, "<C-h>", ":wincmd h<CR>", { silent = false, remap = false, desc = "Move left a split" })
vim.keymap.set({ "n" }, "<C-l>", ":wincmd l<CR>", { silent = false, remap = false, desc = "Move right a split" })
vim.keymap.set({ "n" }, "<C-w>h", ":sp <CR>", { silent = true, remap = false, desc = "Split Window Horizontally" })

vim.keymap.set({ "n" }, "<leader>yy", ":%y+<CR><CR>", { silent = true, remap = false, desc = "Yank the Entire Buffer" })
vim.keymap.set({ "n" }, "<S-o>", "^i<CR><Esc>k^i", { silent = true, remap = false, desc = "Insert Line Above" })
vim.keymap.set({ "n" }, "<C-c>", ":bp|bd #<CR>", { silent = true, remap = false, desc = "Close Buffer but Keep the Split" })
vim.keymap.set({ "n" }, "q:", "<Nop>", {})
vim.keymap.set({ "n" }, "<space>", "<Nop>", {})
vim.keymap.set({ "n" }, "<leader>cc", function()
if vim.wo.cc == "101" then
    vim.opt.colorcolumn = "0"
else
    vim.opt.colorcolumn = "101"
end
end, { desc = "Toggle Colorcolumn" })

-- diagnostics
vim.keymap.set({ "n" }, "[d", vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic Message" })
vim.keymap.set({ "n" }, "]d", vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic Message" })
vim.keymap.set({ "n" }, "<leader>dm", vim.diagnostic.open_float, { desc = "Open Floating Diagnostic Message" })
vim.keymap.set({ "n" }, "<leader>dl", vim.diagnostic.setloclist, { desc = "Open Diagnostic List" })

-- leap
vim.keymap.set({ "n", "v" }, "s", "<Plug>(leap-forward-to)", { remap = true, desc = "Leap Forward" })
vim.keymap.set({ "n", "v" }, "<S-s>", "<Plug>(leap-backward-to)", { remap = true, desc = "Leap Backward" })

-- gitsigns
vim.keymap.set({ "n" }, "[g", require("gitsigns").prev_hunk, { desc = "Go to Previous Hunk" })
vim.keymap.set({ "n" }, "]g", require("gitsigns").next_hunk, { desc = "Go to Next Hunk" })
vim.keymap.set({ "n" }, "<leader>ph", require("gitsigns").preview_hunk, { desc = "Preview Hunk" })

-- debug
-- vim.keymap.set({ "n" }, "<F7>", require("dapui").toggle, { desc = "Toggle DapUi" })
-- vim.keymap.set({ "n" }, "<F6>", require("dap").terminate, { desc = "Terminate Dap" })
-- vim.keymap.set({ "n" }, "<F5>", require("dap").continue, { desc = "Continue Dap" })
-- vim.keymap.set({ "n" }, "<F1>", require("dap").step_into, { desc = "Step Into" })
-- vim.keymap.set({ "n" }, "<F2>", require("dap").step_over, { desc = "Step Over" })
-- vim.keymap.set({ "n" }, "<F3>", require("dap").step_out, { desc = "Step Out" })
-- vim.keymap.set({ "n" }, "<leader>b", require("dap").toggle_breakpoint, { desc = "Toggle Breakpoint" })
-- vim.keymap.set({ "n" }, "<leader>B", function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end, { desc = "Set Breakpoint Condition" })

-- telescope
vim.keymap.set({ "n" }, "<leader>?", require("telescope.builtin").oldfiles, { desc = "Find Recently Opened Files" })
vim.keymap.set({ "n" }, "<leader><space>", require("telescope.builtin").buffers, { desc = "Find Existing Buffers" })
vim.keymap.set({ "n" }, "<leader>ff", require("telescope.builtin").find_files, { desc = "Search Files" })
vim.keymap.set({ "n" }, "<leader>gf", require("telescope.builtin").git_files, { desc = "Search Git Files" })
vim.keymap.set({ "n" }, "<leader>sh", require("telescope.builtin").help_tags, { desc = "Search Help" })
vim.keymap.set({ "n" }, "<leader>sw", require("telescope.builtin").grep_string, { desc = "Search Current Word" })
vim.keymap.set({ "n" }, "<leader>sg", require("telescope.builtin").live_grep, { desc = "Search by Grep" })
vim.keymap.set({ "n" }, "<leader>sd", require("telescope.builtin").diagnostics, { desc = "Search Diagnostics" })
vim.keymap.set({ "n" }, "<leader>/", function()
require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    previewer = false
})
end, { desc = "Fuzzily Search in Current Buffer" })

-- Workspaces
vim.keymap.set({ "n" }, "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Workspace Add Folder" })
vim.keymap.set({ "n" }, "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Workspace Remove Folder" })
vim.keymap.set({ "n" }, "<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "Workspace List Folders" })
