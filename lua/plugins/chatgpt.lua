return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup({
        -- optional configuration
        -- keymaps = {
        --   submit = "<C-a>",
        -- },
        api_key_cmd = "pass show api/tokens/openai",
        -- async_api_key_cmd = "",
      })
    end,
  },
}
