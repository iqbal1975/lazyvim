return {
  { "nvim-neotest/neotest-go" },
  { "nvim-neotest/neotest-plenary" },
  { "nvim-neotest/neotest-python" },
  { "rouge8/neotest-rust" },
  { "nvim-neotest/neotest-vim-test" },
  opts = {
    -- Can be a list of adapters like what neotest expects,
    -- or a list of adapter names,
    -- or a table of adapter names, mapped to adapter configs.
    -- The adapter will then be automatically loaded with the config.
    -- adapters = {},
    -- Example for loading neotest-go with a custom config
    adapters = {
      ["neotest-go"] = {
        args = { "-tags=integration" },
      },
      ["neotest-plenary"] = {},
      ["neotest-python"] = {
        -- Here you can specify the settings for the adapter, i.e.
        -- python = ".venv/bin/python",
        dap = {
          justMyCode = false,
          console = "integratedTerminal",
        },
        args = { "--log-level", "DEBUG", "--quiet" },
        runner = "pytest",
      },
      ["neotest-rust"] = {
        args = { "--no-capture" },
        dap_adapter = "lldb",
      },
      ["neotest-vim-test"] = {
        ignore_file_types = { "lua", "go", "python", "rust", "vim" },
      },
    },
  },
  keys = {
    {
      "<leader>dm",
      "<cmd>lua require('neotest').run.run()<cr>",
      desc = "Test Method",
    },
    {
      "<leader>dM",
      "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
      desc = "Test Method DAP",
    },
    {
      "<leader>df",
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
      desc = "Test Class",
    },
    {
      "<leader>dF",
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
      desc = "Test Class DAP",
    },
    {
      "<leader>dS",
      "<cmd>lua require('neotest').summary.toggle()<cr>",
      desc = "Test Summary",
    },
  },
}
