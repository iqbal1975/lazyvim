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

-- Clear Search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { noremap = true, silent = false, desc = "Clear Search" })
-- Clear Search

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
vim.keymap.set("n", "<C-A>", mark.add_file, { desc = "Harpoon Mark" })
vim.keymap.set("n", "<C-E>", ui.toggle_quick_menu, { desc = "Harpoon Menu" })

local hk = require("which-key")
hk.register({
  A = {
    name = "Harpoon",
    a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add File" },
    r = { "<cmd>lua require('harpoon.mark').rm_file()<cr>", "Remove File" },
    m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon Menu" },
    n = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Next File" },
    p = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Previous File" },
    ["1"] = { "<cmd> lua require('harpoon.ui').nav_file(1)<cr>", "File 1" },
    ["2"] = { "<cmd> lua require('harpoon.ui').nav_file(2)<cr>", "File 2" },
    ["3"] = { "<cmd> lua require('harpoon.ui').nav_file(3)<cr>", "File 3" },
    ["4"] = { "<cmd> lua require('harpoon.ui').nav_file(4)<cr>", "File 4" },
    ["5"] = { "<cmd> lua require('harpoon.ui').nav_file(5)<cr>", "File 5" },
  },
  H = {
    name = "Help/Debug/Conceal",
    c = {
      name = "Conceal",
      h = { ":set conceallevel=1<cr>", "Hide/Conceal" },
      s = { ":set conceallevel=0<cr>", "Show/Unconceal" },
    },
    t = {
      name = "Treesitter",
      t = { vim.treesitter.inspect_tree, "Show Tree" },
      c = { ":=vim.treesitter.get_captures_at_cursor()<cr>", "Show Capture" },
      n = { ":=vim.treesitter.get_node():type()<cr>", "Show Node" },
    },
  },
}, { prefix = "<leader>" })

vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
-- Harpoon Keymaps

-- Telescope Keymap
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)
-- Telescope Keymap

-- Zk Keymap
local zk = require("which-key")
zk.register({
  z = {
    name = "Zk Notes",
  },
}, { prefix = "<leader>" })
-- Zk Keymap
