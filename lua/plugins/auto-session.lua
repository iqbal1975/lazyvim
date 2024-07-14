return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = {
        "~/",
        "~/Desktop/",
        "~/Documents/",
        "~/Downloads/",
        "~/Music/",
        "~/Neorg/",
        "~/Notes/",
        "~/Pictures/",
        "~/Public/",
        "~/Templates/",
        "~/Videos/",
      },
    })

    -- Auto-session Keymaps
    local wk = require("which-key")
    wk.add({
      { "<leader>S", group = "Session" },
    })

    local keymap = vim.keymap

    -- Restore last Workspace session for Current Directory
    keymap.set("n", "<leader>SR", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
    -- Save Workspace session for Current Working Directory
    keymap.set("n", "<leader>SS", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
    -- Auto-session Keymaps
  end,
}
