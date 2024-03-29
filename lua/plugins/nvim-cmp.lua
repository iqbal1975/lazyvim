return {
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
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" }, -- source for text in buffer
    { "hrsh7th/cmp-path" }, -- source for file system paths
    { "saadparwaiz1/cmp_luasnip" }, -- for autocompletion
    { "rafamadriz/friendly-snippets" }, -- useful snippets
    -- { "onsails/lspkind.nvim" }, -- vs-code like pictograms
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- local luasnip = require("luasnip")
    local cmp = require("cmp")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    -- require("luasnip.loaders.from_vscode").lazy_load()

    local defaults = require("cmp.config.default")()
    return {

      completion = {
        completeopt = "menu,menuone,noinsert,noselect,preview",
      },

      sources = {
        { name = "emoji" },
        { name = "codeium" },
        { name = "crates" },
        { name = "nvim_lsp" },
        -- { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      },

      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- previous suggestion
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- next suggestion
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- show completion suggestions
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
            -- elseif luasnip.expand_or_jumpable() then
            --   luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          -- elseif luasnip.jumpable(-1) then
          --   luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },

      formatting = {
        format = function(_, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          -- local codeium = require("lspkind").cmp_format({
          --   mode = "symbol",
          --   maxwidth = 50,
          --   ellipsis_char = "...",
          --   symbol_map = { Codeium = "" },
          -- })
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
