return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup({
      -- prompt for return type
      prompt_func_return_type = {
        c = true,
        cpp = true,
        go = true,
        java = true,
      },
      -- prompt for function parameters
      prompt_func_param_type = {
        c = true,
        cpp = true,
        go = true,
        java = true,
      },
    })
  end,
}
