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

  -- Feed
  { "neo451/feed.nvim", cmd = "Feed" },

  -- Fugit2
  {
    "SuperBo/fugit2.nvim",
    -- enabled = false,
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    cmd = { "Fugit2", "Fugit2Graph" },
    keys = {
      { "<leader>gF", mode = "n", "<cmd>Fugit2<cr>", desc = "Fugit2" },
    },
  },

  -- Join-Line Opposite
  {
    "AckslD/nvim-trevJ.lua",
    config = 'require("trevj").setup()',
    init = function()
      vim.keymap.set("n", "<leader>o", function()
        require("trevj").format_at_cursor()
      end, { desc = "Join-Line Opposite" })
    end,
  },

  -- HTTP-client Interface
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>cR", desc = "Send request" },
      { "<leader>cA", desc = "Send all requests" },
      { "<leader>cB", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      global_keymaps = false,
      global_keymaps_prefix = "<leader>c",
      kulala_keymaps_prefix = "",
    },
  },

  -- Oil.nvim
  {
    "stevearc/oil.nvim",

    ---@module 'oil'
    ---@type oil.SetupOpts

    opts = {},
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    lazy = false,

    -- Oil Keymaps
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Oil - Parent Directory" }),
    vim.keymap.set("n", ".", "<CMD>Oil toggle_hidden<CR>", { desc = "Oil - Toggle Hidden" }),
    vim.keymap.set("n", "<C-\\>", "<CMD>Oil toggle_trash<CR>", { desc = "Oil - Toggle Trash" }),
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
      vim.keymap.set("n", "<leader>uy", require("tidy").toggle, { desc = "Toggle Tidy" })
    end,
  },

  -- TODO
  {
    "folke/todo-comments.nvim",
    optional = true,
    keys = {
      {
        "<leader>st",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },

  -- Vim Wakatime
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
}
