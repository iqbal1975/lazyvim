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
      colorscheme = "catppuccin",
      opts = {
        integrations = {
          alpha = true,
          cmp = true,
          flash = true,
          gitsigns = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          lsp_trouble = true,
          mason = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          neotest = true,
          noice = true,
          notify = true,
          neotree = true,
          semantic_tokens = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
      },
      -- Moonbow Colorscheme
      -- colorscheme = "moonbow",
    },
  },
}
