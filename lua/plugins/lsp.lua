return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "b0o/SchemaStore.nvim",
      version = false, -- last release is way too old
    },
    { "jose-elias-alvarez/typescript.nvim" },
  },
  opts = {
    servers = {},
  },
  setup = {},
}
