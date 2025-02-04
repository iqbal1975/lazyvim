return {
  {
    "jackMort/ChatGPT.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      -- "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "pass show api/tokens/openai",
        -- async_api_key_cmd = "",
        -- this config assumes you have OPENAI_API_KEY environment variable set
        openai_params = {
          -- NOTE: model can be a function returning the model name
          -- this is useful if you want to change the model on the fly
          -- using commands
          -- Example:
          -- model = function()
          --     if some_condition() then
          --         return "gpt-4-1106-preview"
          --     else
          --         return "gpt-3.5-turbo"
          --     end
          -- end,
          model = "gpt-4-1106-preview",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4095,
          temperature = 0.2,
          top_p = 0.1,
          n = 1,
        },
      })

      -- Github Keymaps
      local wk = require("which-key")
      wk.add({
        { "<leader>C", group = "ChatGPT" },
        { "<leader>Cc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
        {
          -- Nested mappings are allowed and can be added in any order
          -- Most attributes can be inherited or overridden on any level
          -- There's no limit to the depth of nesting
          mode = { "n", "v" }, -- NORMAL and VISUAL mode
          { "<leader>Ca", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests" },
          { "<leader>Cd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring" },
          { "<leader>Ce", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with Instruction" },
          { "<leader>Cf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs" },
          { "<leader>Cg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction" },
          { "<leader>Ck", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords" },
          {
            "<leader>Cl",
            "<cmd>ChatGPTRun code_readability_analysis<CR>",
            desc = "Code Readability Analysis",
          },
          { "<leader>Co", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code" },
          { "<leader>Cr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit" },
          { "<leader>Cs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize" },
          { "<leader>Ct", "<cmd>ChatGPTRun translate<CR>", desc = "Translate" },
          { "<leader>Cx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code" },
        },
      })
      -- Github Keymaps
    end,
  },
}
