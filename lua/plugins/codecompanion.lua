return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
  -- {
  --   "ravitemer/mcphub.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   build = "npm install -g mcp-hub@latest",
  --   config = function()
  --     require("mcphub").setup({
  --       port = 3600,
  --       config = vim.fn.expand("~/mcpservers.json"),
  --     })
  --   end,
  -- },
  opts = {
    send_code = false,
    adapters = {
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            -- api_key = "cmd:op read op://personal/OpenAI/credential --no-newline",
            api_key = "OPENAI_API_KEY",
          },
          schema = {
            model = {
              -- default = "gpt-4o",
              default = "o1-2024-12-17",
            },
          },
        })
      end,
    },
    display = {
      chat = {
        intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
        show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
        separator = "─", -- The separator between the different messages in the chat buffer
        show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
        show_settings = false, -- Show LLM settings at the top of the chat buffer?
        show_token_count = true, -- Show the token count for each response?
        start_in_insert_mode = false, -- Open the chat buffer in insert mode?
        -- Change the default icons
        icons = {
          pinned_buffer = " ",
          watched_buffer = "👀 ",
        },

        -- Alter the sizing of the debug window
        debug_window = {
          ---@return number|fun(): number
          width = vim.o.columns - 5,
          ---@return number|fun(): number
          height = vim.o.lines - 2,
        },

        -- Options to customize the UI of the chat buffer
        window = {
          layout = "vertical", -- float|vertical|horizontal|buffer
          position = nil, -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
          border = "single",
          height = 0.8,
          width = 0.45,
          relative = "editor",
          opts = {
            breakindent = true,
            cursorcolumn = false,
            cursorline = false,
            foldcolumn = "0",
            linebreak = true,
            list = false,
            numberwidth = 1,
            signcolumn = "no",
            spell = false,
            wrap = true,
          },
        },

        ---Customize how tokens are displayed
        ---@param tokens number
        ---@return string
        token_count = function(tokens)
          return " (" .. tokens .. " tokens)"
        end,
      },
      inline = {
        layout = "vertical", -- vertical|horizontal|buffer
      },
      diff = {
        enabled = true,
        close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
        layout = "vertical", -- vertical|horizontal split for default provider
        opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
        provider = "default", -- default|mini_diff
      },
    },
    strategies = {
      -- Change the default chat adapter
      chat = {
        adapter = "anthropic",
        -- adapter = "openai",
        keymaps = {
          send = {
            modes = { n = "<C-s>", i = "<C-s>" },
          },
          close = {
            modes = { n = "<C-c>", i = "<C-c>" },
          },
          -- Add further custom keymaps here
        },
        -- tools = {
        --   ["mcp"] = {
        --     callback = require("mcphub.extensions.codecompanion"),
        --     description = "Call tools and resources from the MCP Servers",
        --     opts = {
        --       user_approval = true,
        --     },
        --   },
        -- },
        roles = {
          ---The header name for the LLM's messages
          ---@type string|fun(adapter: table): string
          llm = function(adapter)
            return "CodeCompanion (" .. adapter.formatted_name .. ")"
          end,

          ---The header name for your messages
          ---@type string
          user = "Iqbal",
        },
      },
      inline = {
        -- adapter = "anthropic",
        adapter = "copilot",
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "gr" },
            description = "Reject the suggested change",
          },
        },
      },
    },
    opts = {
      -- Turn on logging
      log_level = "DEBUG", -- or "TRACE"
    },
  },
  init = function()
    require("plugins.codecompanion.fidget-spinner"):init()
  end,
}
