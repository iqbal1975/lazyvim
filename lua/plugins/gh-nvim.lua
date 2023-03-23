return {
  "ldelossa/gh.nvim",
  dependencies = { { "ldelossa/litee.nvim" } },
  config = function()
    require("litee.lib").setup({
      tree = {
        icon_set = "codicons",
      },
      panel = {
        orientation = "left",
        panel_size = 30,
      },
    })
  end,
}
