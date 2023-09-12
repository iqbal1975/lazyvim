return{
  -- Extend Auto Completion
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    { "hrsh7th/cmp-emoji" },
    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      config = true,
    },
    { "hrsh7th/cmp-nvim-lsp", },
    { "hrsh7th/cmp-buffer" }, -- source for text in buffer
    { "hrsh7th/cmp-path" }, -- source for file system paths
    { "L3MON4D3/LuaSnip" }, -- snippet engine
    { "saadparwaiz1/cmp_luasnip" }, -- for autocompletion
    { "rafamadriz/friendly-snippets" }, -- useful snippets
    -- { "onsails/lspkind.nvim" }, -- vs-code like pictograms
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local cmp = require("cmp")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    local defaults = require("cmp.config.default")()
    return {

      completion = {
        completeopt = "menu,menuone,noinsert,noselect,preview",
      },

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      sources = {
        { name = "emoji" },
        { name = "crates" },
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      },

      mapping = {
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
      },

      formatting = {
        format = function(_, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          return item
        end,
      },

      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },

      sorting = defaults.sorting,
    }
  end,
}
