return {
  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "abeldekat/harpoonline",
    -- config = function()
    --   local Harpoonline = require("harpoonline")
    --   Harpoonline.setup({
    --     custom_formatter = Harpoonline.gen_override("extended", {
    --       indicators = { "1", "2", "3", "4", "5" },
    --       active_indicators = { "[1]", "[2]", "[3]", "[4]", "[5]" },
    --     }),
    --   })
    --   local lualine_d = { Harpoonline.format, "filename" }
    --
    --   require("lualine").setup({
    --     sections = {
    --       lualine_d = lualine_d,
    --     },
    --   })
    -- end,
    opts = function(_, opts)
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
      })
      table.insert(opts.sections.lualine_c, {
        symbols.get,
        cond = symbols.has,
      })
      -- table.insert(opts.sections.lualine_x, "😄")
    end,
  },
}
