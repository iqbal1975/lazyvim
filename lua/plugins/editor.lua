-- Every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enable LazyVim plugins
-- * override the configuration of LazyVim plugins
return {

  -- Code Folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
  },

  -- CONDA Environment
  {
    "kmontocam/nvim-conda",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Editor config support
  {
    "editorconfig/editorconfig-vim",
    event = "VeryLazy",
  },

  -- fzf-lua
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
  },

  -- Join-Line Opposite
  {
    "AckslD/nvim-trevJ.lua",
    config = 'require("trevj").setup()',
    init = function()
      vim.keymap.set("n", "<leader>j", function()
        require("trevj").format_at_cursor()
      end, { desc = "Join-Line Opposite" })
    end,
  },

  -- Scopes
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = true,
  },

  -- Shebang
  {
    "susensio/magic-bang.nvim",
    event = "BufNewFile",
    cmd = "Bang",
    config = function()
      require("magic-bang").setup({
        bin = {
          py = "python",
          scala = nil,
        },
      })
    end,
  },

  -- Switch Python venv
  { "ChristianChiarulli/swenv.nvim" },

  -- Telescope Import
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
    end,
  },

  -- Tidy
  {
    "mcauley-penney/tidy.nvim",
    event = "VeryLazy",
    config = function()
      require("tidy").setup({
        filetype_exclude = { "markdown", "diff" },
      })
    end,
    init = function()
      vim.keymap.set("n", "<leader>y", require("tidy").toggle, { desc = "Toggle Tidy" })
    end,
  },

  -- Twilight
  {
    "folke/twilight.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- Vim Tmux Navigator
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- Vim Tmux Navigator
  {
    "wakatime/vim-wakatime",
  },

  -- What the Fudge Diagnostic
  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {},
    keys = {
      {
        "gw",
        mode = { "n", "x" },
        function()
          require("wtf").ai()
        end,
        desc = "Debug diagnostic with AI",
      },
      {
        mode = { "n" },
        "gW",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
    },
    hooks = {
      request_started = function()
        vim.cmd("hi StatusLine ctermbg=NONE ctermfg=yellow")
      end,
      request_finished = vim.schedule_wrap(function()
        vim.cmd("hi StatusLine ctermbg=NONE ctermfg=NONE")
      end),
    },
  },

  -- Zen-mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = true,
    -- dependencies = {
    --   "folke/twilight.nvim",
    -- },
    keys = { { "<leader>Z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
