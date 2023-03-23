-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- BTop Terminal
if vim.fn.executable("btop") == 1 then
  -- btop
  vim.keymap.set("n", "<leader>xb", function()
    require("lazyvim.util").float_term({ "btop --utf-force" })
  end, { desc = "BTop" })
end
-- BTop Terminal

-- Github Keymaps
local wk = require("which-key")
wk.register({
  g = {
    name = "+Git",
    H = {
      name = "+Github",
      c = {
        name = "+Commits",
        c = { "<cmd>GHCloseCommit<cr>", "Close" },
        e = { "<cmd>GHExpandCommit<cr>", "Expand" },
        o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
        p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
        z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
      },
      i = {
        name = "+Issues",
        p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
      },
      l = {
        name = "+Litee",
        t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
      },
      r = {
        name = "+Review",
        b = { "<cmd>GHStartReview<cr>", "Begin" },
        c = { "<cmd>GHCloseReview<cr>", "Close" },
        d = { "<cmd>GHDeleteReview<cr>", "Delete" },
        e = { "<cmd>GHExpandReview<cr>", "Expand" },
        s = { "<cmd>GHSubmitReview<cr>", "Submit" },
        z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
      },
      p = {
        name = "+Pull Request",
        c = { "<cmd>GHClosePR<cr>", "Close" },
        d = { "<cmd>GHPRDetails<cr>", "Details" },
        e = { "<cmd>GHExpandPR<cr>", "Expand" },
        o = { "<cmd>GHOpenPR<cr>", "Open" },
        p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
        r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
        t = { "<cmd>GHOpenToPR<cr>", "Open To" },
        z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
      },
      t = {
        name = "+Threads",
        c = { "<cmd>GHCreateThread<cr>", "Create" },
        n = { "<cmd>GHNextThread<cr>", "Next" },
        t = { "<cmd>GHToggleThread<cr>", "Toggle" },
      },
    },
  },
}, { prefix = "<leader>" })
-- Github Keymaps

-- Harpoon Keymaps
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-1>", function()
  ui.nav_file(1)
end)
vim.keymap.set("n", "<C-2>", function()
  ui.nav_file(2)
end)
vim.keymap.set("n", "<C-3>", function()
  ui.nav_file(3)
end)
vim.keymap.set("n", "<C-4>", function()
  ui.nav_file(4)
end)
-- Harpoon Keymaps

-- Telescope Keymap
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)
-- Telescope Keymap

-- Zk Keymaps
-- Create a new note after asking for its title.
vim.keymap.set(
  "n",
  "<leader>zn",
  "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
  { noremap = true, silent = false, desc = "Create New Note" }
)

-- Open notes.
vim.keymap.set(
  "n",
  "<leader>zo",
  "<Cmd>ZkNotes { sort = { 'modified' } }<CR>",
  { noremap = true, silent = false, desc = "Open Notes" }
)
-- Open notes associated with the selected tags.
vim.keymap.set("n", "<leader>zt", "<Cmd>ZkTags<CR>", { noremap = true, silent = false, desc = "Open Notes with Tags" })

-- Search for the notes matching a given query.
vim.keymap.set(
  "n",
  "<leader>zf",
  "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
  { noremap = true, silent = false, desc = "Search Notes Matching" }
)
-- Search for the notes matching the current visual selection.
vim.keymap.set(
  "v",
  "<leader>zf",
  ":'<,'>ZkMatch<CR>",
  { noremap = true, silent = false, desc = "Search Notes Matching" }
)
-- Zk Keymaps
