-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- {{{ Alphabetical listing of settings I like.

local options = {
  background = "dark", -- set this to dark or light
  colorcolumn = "120",
  completeopt = { "menuone", "noinsert", "noselect" },
  listchars = { -- list of hidden characters
    tab = "» ",
    trail = "•",
    precedes = "←",
    extends = "→",
    eol = "↲",
    space = "␣",
  },
  nrformats = { "alpha", "octal", "hex" },
  showbreak = "↪",
  splitbelow = true,
  splitright = true,
  -- statuscolumn = "%l %r",
  -- winbar = "%=%m %f"
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd([[filetype plugin indent on]])

vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

-- ------------------------------------------------------------------------- }}}
