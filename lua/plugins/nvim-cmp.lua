return{
  "ChristianChiarulli/swenv.nvim",
  -- Extend Auto Completion
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    { "hrsh7th/cmp-emoji" },
    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      config = true,
    },
    { "hrsh7th/cmp-buffer" }, -- source for text in buffer
    { "hrsh7th/cmp-path" }, -- source for file system paths
    { "L3MON4D3/LuaSnip" }, -- snippet engine
    { "saadparwaiz1/cmp_luasnip" }, -- for autocompletion
    { "rafamadriz/friendly-snippets" }, -- useful snippets
    { "onsails/lspkind.nvim" }, -- vs-code like pictograms
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    -- original LazyVim kind icon formatter
    local format_kinds = opts.formatting.format
    opts.formatting.format = function(entry, item)
      format_kinds(entry, item) -- add icons
      return require("tailwindcss-colorizer-cmp").formatter(entry, item)
    end

    local cmp = require("cmp")

    local luasnip = require("luasnip")

    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    opts.completion = cmp.config.completion({
      completeopt = "menu,menuone,preview,noselect",
    })

    opts.snippet = cmp.config.snippet({ -- configure how nvim-cmp interacts with snippet engine
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    })

    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
      { name = "emoji" },
      { name = "crates" },
      { name = "nvim_lsp" },
      { name = "luasnip" }, -- snippets
      { name = "buffer" }, -- text within current buffer
      { name = "path" }, -- file system paths
    }))

    opts.mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- previous suggestion
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- next suggestion
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- show completion suggestions
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }), -- close completion window
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    })

    -- configure lspkind for vs-code like pictograms in completion menu
    opts.formatting = cmp.config.formatting({
      format = lspkind.cmp_format({
        maxwidth = 50,
        ellipsis_char = "...",
      }),
    })
  end,
  keys = {
    {
      "<leader>Y",
      "<cmd>lua require('swenv.api').pick_venv()<cr>",
      "Choose Env",
      desc = "Python",
    },
  },
}
