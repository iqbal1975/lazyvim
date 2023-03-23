return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-debug-adapter",
        "codelldb",
        "delve",
        "eslint_d",
        "flake8",
        "prettier",
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
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
        "luals",
        "marksman",
        "prosemd_lsp",
        "pyright",
        "rust_analyzer",
        "tailwindcss",
        "tsserver",
        "yamlls",
        "zk",
      },
    },
  },
}
