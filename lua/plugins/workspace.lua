return {
  "sanathks/workspace.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("workspace").setup({
      workspaces = {
        { name = "Personal", path = "~/Workspace/Personal", keymap = { "<leader>P" } },
        { name = "Work", path = "~/Workspace/Work", keymap = { "<leader>W" } },
      },
    })
  end,
}
