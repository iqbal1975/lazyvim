return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-null-ls.nvim",
  },

  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- import mason-null-ls
    local mason_null_ls = require("mason-null-ls")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ensure_installed = {
        "bash-debug-adapter",
        "codelldb",
        "delve",
        "flake8",
        "js-debug-adapter",
        "shellcheck",
        "shfmt",
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "emmet_ls",
        "eslint",
        "gopls",
        "html",
        "intelephense",
        "jsonls",
        "julials",
        "lua_ls",
        "marksman",
        "prosemd_lsp",
        "pyright",
        "rust_analyzer",
        "tailwindcss",
        "tsserver",
        "yamlls",
        "zk",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_null_ls.setup({
      -- list of formatters & linters for mason to install
      ensure_installed = {
        "prettier", -- ts/js formatter
        "stylua", -- lua formatter
        "eslint_d", -- ts/js linter
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true,
    })
  end,
}
