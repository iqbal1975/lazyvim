return {
  {
  "sanathks/workspace.nvim",
  dependencies = {"nvim-telescope/telescope.nvim"},
  config = function()
    require("workspace").setup({
      workspaces = {
        { name = "Work",  path = "~/Workspace/work",  keymap = { "<leader>W" , { desc = "Work Workspace" } } },
        { name = "Personal", path = "~/Workspace/personal", keymap = { "<leader>P" , { desc = "Personal Workspace" } } },
      },
    })
  end,
  tmux_session_name_generator = function(project_name, workspace_name)
      local suffix = string.sub(workspace_name, 1, 2)
      local session_name = string.upper(project_name) .. "_" .. suffix
    return session_name
  end,
  },
}
