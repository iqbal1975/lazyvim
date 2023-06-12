return {

  -- Tokyonight Colorscheme
  { "folke/tokyonight.nvim" },

  -- Catppuccin Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = true,
  },

  -- Moonbow Colorscheme
  { "arturgoms/moonbow.nvim" },

  -- OneNord Colorscheme
  { "rmehri01/onenord.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      -- Tokyonight Colorscheme
      -- colorscheme = "tokyonight",
      -- style = "night",
      -- Catppuccin Colorscheme
      colorscheme = "catppuccin-mocha",
      opts = nil,
      -- Moonbow Colorscheme
      -- colorscheme = "moonbow",
    },
  },
}
