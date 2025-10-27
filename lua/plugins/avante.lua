-- Avante.nvim configuration
-- AI assistant for Neovim

-- Model configurations
local models = {
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-7-sonnet",
    timeout = 30000,
    disable_tools = true,
    extra_request_body = {
      -- Claude 3.7 Sonnet has a max context length of 100k tokens
      max_tokens = 100000,
      max_completion_tokens = 8192, -- this is the maximum value for Claude 3.7 Sonnet
      reasoning_effort = "high", -- only supported for Claude models
    },
  },

  copilot = {
    model = "gpt-4o",
    endpoint = "https://api.githubcopilot.com",
    allow_insecure = false,
    timeout = 10 * 60 * 1000,
    extra_request_body = { temperature = 0 },
    max_completion_tokens = 1000000,
    reasoning_effort = "high",
  },

  groq = {
    __inherited_from = 'openai',
    api_key_name = 'GROQ_API_KEY',
    endpoint = 'https://api.groq.com/openai/v1/',
    model = 'llama-3.3-70b-versatile',
    disable_tools = true,
    extra_request_body = {
      temperature = 1,
      max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
    },
  },

  mistral= {
    __inherited_from = "openai",
    api_key_name = "MISTRAL_API_KEY",
    endpoint = "https://api.mistral.ai/v1/",
    model = "mistral-large-latest",
    extra_request_body = {
      max_tokens = 4096, -- to avoid using max_completion_tokens
    },
  },

  ollama = {
    endpoint = "http://localhost:11434",
    model = "llama3:latest",
  },

  openai = {
    endpoint = "https://api.openai.com/v1",
    model = "o1-mini",
    timeout = 30000,
    disable_tools = true,
    extra_request_body = {
      temperature = 0,
      max_tokens = 4096,
      max_completion_tokens = 8192,
      reasoning_effort = "high", -- only supported for "o" models
    },
  },
}

-- Selected provider
local selected_provider = "copilot" -- Options: "claude", "copilot", "gemini", "groq", "mistral", "ollama", "openai"

-- Optional dependencies configuration
local optional_deps = {
  {
    "Kaiser-Yang/blink-cmp-avante",
    lazy = true,
    specs = {
      {
        "saghen/blink.cmp",
        optional = true,
        opts = {
          sources = {
            default = { "avante" },
            providers = { avante = { module = "blink-cmp-avante", name = "Avante" } },
          },
        },
      },
    },
  },

  {
    -- Support for image pasting
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = { insert_mode = true },
        use_absolute_path = true, -- required for Windows users
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    ft = function(_, ft)
      vim.list_extend(ft, { "markdown", "Avante" })
    end,
    opts = function(_, opts)
      opts.file_types = vim.list_extend(opts.file_types or {}, { "markdown", "Avante" })
    end,
  },
}

-- Required dependencies
local required_deps = {
  "nvim-treesitter/nvim-treesitter",
  "stevearc/dressing.nvim",
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
}

-- RAG Service configuration
local rag_service = {
  -- enabled = false, -- Enables the RAG service
  host_mount = os.getenv("HOME"), -- Host mount path for the rag service (Docker will mount this path)
  runner = "docker", -- Runner for the RAG service (can use docker or nix)
  -- llm = { -- Language Model (LLM) configuration for RAG service
  --   provider = "openai", -- LLM provider
  --   endpoint = "https://api.openai.com/v1", -- LLM API endpoint
  --   api_key = "OPENAI_API_KEY", -- Environment variable name for the LLM API key
  --   model = "gpt-4o-mini", -- LLM model name
  --   extra = nil, -- Additional configuration options for LLM
  -- },
  -- embed = { -- Embedding model configuration for RAG service
  --   provider = "openai", -- Embedding provider
  --   endpoint = "https://api.openai.com/v1", -- Embedding API endpoint
  --   api_key = "OPENAI_API_KEY", -- Environment variable name for the embedding API key
  --   model = "text-embedding-3-large", -- Embedding model name
  --   extra = nil, -- Additional configuration options for the embedding model
  -- },
  llm = { -- Configuration for the Language Model (LLM) used by the RAG service
    provider = "ollama", -- The LLM provider ("ollama")
    endpoint = "http://localhost:11434", -- The LLM API endpoint for Ollama
    api_key = "", -- Ollama typically does not require an API key
    model = "mistral:latest", -- The LLM model name (e.g., "llama2", "mistral")
    extra = nil, -- Extra configuration options for the LLM (optional) Kristin", -- Extra configuration options for the LLM (optional)
  },
  embed = { -- Configuration for the Embedding Model used by the RAG service
    provider = "ollama", -- The Embedding provider ("ollama")
    endpoint = "http://localhost:11434", -- The Embedding API endpoint for Ollama
    api_key = "", -- Ollama typically does not require an API key
    model = "nomic-embed-text", -- The Embedding model name (e.g., "nomic-embed-text")
    extra = { -- Extra configuration options for the Embedding model (optional)
      embed_batch_size = 10,
    },
  },
  docker_extra_args = "", -- Extra arguments to pass to the docker command
}

return {
  {
    "yetone/avante.nvim",
    -- enabled = false, -- set this to true to enable the plugin
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = function()
      -- conditionally use the correct build system for the current OS
      if vim.fn.has("win32") == 1 then
        return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      else
        return "make"
      end
    end,
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!

    keys = {
      {
        "<leader>a+",
        function()
          local tree_ext = require("avante.extensions.nvim_tree")
          tree_ext.add_file()
        end,
        desc = "Select file in NvimTree",
        ft = "NvimTree",
      },
      {
        "<leader>a-",
        function()
          local tree_ext = require("avante.extensions.nvim_tree")
          tree_ext.remove_file()
        end,
        desc = "Deselect file in NvimTree",
        ft = "NvimTree",
      },
    },

    opts = {
      hints = { enabled = false },
      provider = selected_provider,
      cursor_applying_provider = 'groq', -- In this example, use Groq for applying, but you can also use any provider you want.
      providers = models,
      auto_suggestions_provider = nil,
      behaviour = {
        auto_suggestions = false,
        --- ... existing behaviours
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
      },

      -- File selector configuration
      file_selector = {
        provider = "snacks", -- Avoid native provider issues
        provider_opts = {},
      },
      selector = {
        exclude_auto_select = { "NvimTree" },
        provider = "snacks"
      },
      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
      extensions = {
        avante = {
          make_slash_commands = true, -- make /slash commands from MCP server prompts
        },
      },
      input = { provider = "snacks" },
    },

    rag_service = rag_service,

    dependencies = vim.tbl_extend("force", required_deps, optional_deps),
  },
}
