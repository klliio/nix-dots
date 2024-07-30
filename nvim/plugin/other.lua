-- lualine
require("lualine").setup({
	icon_enabled = true,
	theme = "onedark",
})

-- colourscheme
vim.cmd("colorscheme catppuccin")
local colors = require("catppuccin.palettes").get_palette()
local TransparentColours = {
    Normal = { none },
    NormalNC = { none },
    LineNr = { none },
    Folded = { none },
    NonText = { none },
    SpecialKey = { none },
    VertSplit = { none },
    SignColumn = { none },
    EndOfBuffer = { none },
}

-- comment
require("Comment").setup()
