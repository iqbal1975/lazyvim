return { -- Highlight, Edit, and Navigate Code
  {
    -- Configure Treesitter
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPre", "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
      },
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      enabled = true,
      opts = { mode = "cursor", max_lines = 3 },
    },
    cmd = { "TSUpdateSync" },
    keys = {
      { "<C-Space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      -- Autoinstall languages that are not installed
      auto_install = true,

      -- enable syntax highlighting
      highlight = { enable = true },

      -- enable indentation
      indent = { enable = true },

      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = { enable = true },

      -- ensure these language parsers are installed
      ensure_installed = {
        "bash",
        "c",
        "comment",
        "cpp",
        "css",
        "diff",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "java",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "ninja",
        "python",
        "query",
        "regex",
        "ron",
        "rst",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "hyprlang",
        "rasi",
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },

      -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
    config = function(_, opts)
      vim.filetype.add({
        extension = { rasi = "rasi" },
        pattern = {
          [".*/waybar/config"] = "jsonc",
          [".*/mako/config"] = "dosini",
          [".*/kitty/*.conf"] = "bash",
          [".*/hypr/.*%.conf"] = "hyprlang",
        },
      })

      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
