-- lualine
require("lualine").setup({
	icon_enabled = true,
	theme = "onedark",
})

local TransparentColours = {
	"Normal",
	"NormalNC",
	"LineNr",
	"Folded",
	"NonText",
	"SpecialKey",
	"VertSplit",
	"SignColumn",
	"EndOfBuffer",
    "LineNrAbove",
    "LineNrBelow",
    "GitSignsAdd",
    "GitSignsDelete",
    "GitSignsChange",
}
for _, group in pairs(TransparentColours) do
	vim.api.nvim_set_hl(0, group, { guibg = NONE, ctermbg = NONE })
end

-- comment
require("Comment").setup()
