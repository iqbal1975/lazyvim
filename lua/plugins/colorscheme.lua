return {

  -- Tokyonight Colorscheme
  { "folke/tokyonight.nvim" },

  -- Catppuccin Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- priority = 1000,
    lazy = true,
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    -- priority = 1000,
    config = true,
  },

  -- Moonbow Colorscheme
  { "arturgoms/moonbow.nvim" },

  -- OneNord Colorscheme
  { "rmehri01/onenord.nvim" },

  -- Oxocarbon Colorscheme
  { "nyoom-engineering/oxocarbon.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      -- Catppuccin Colorscheme
      -- colorscheme = "catppuccin",
      -- Gruvbox
      colorscheme = "gruvbox",
      -- Moonbow Colorscheme
      -- colorscheme = "moonbow",
      -- Oxocarbon Colorscheme
      -- colorscheme = "oxocarbon",
      -- Tokyonight Colorscheme
      -- colorscheme = "tokyonight",
      -- style = "night",
    },
  },
}
