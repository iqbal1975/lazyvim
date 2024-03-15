return {

  {
    "ldelossa/gh.nvim",
    dependencies = { { "ldelossa/litee.nvim" } },
    config = function()
      require("litee.lib").setup({
        tree = {
          icon_set = "codicons",
        },
        panel = {
          orientation = "left",
          panel_size = 30,
        },
      })
    end,
  },

  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },

  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({ enable_builtin = true })
      vim.cmd([[hi OctoEditable guibg=none]])
    end,
    keys = {
      { "<leader>O", "<cmd>Octo<cr>", desc = "Octo" },
    },
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      -- "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
}
