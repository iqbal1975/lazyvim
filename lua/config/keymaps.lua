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

-- Refactoring Keymaps
local rk = require("which-key")
rk.register({
  R = {
    name = "+Refactoring",
    b = {
      name = "+Block",
    },
    e = {
      name = "+Extract",
    },
    i = {
      name = "+Inline",
    },
  },
}, { prefix = "<leader>" })

local refactor = require("refactoring")

-- Extract function supports only Visual mode
vim.keymap.set("x", "<leader>Ree", function()
  refactor.refactor("Extract Function")
end, { desc = "V Extract Function" })
vim.keymap.set("x", "<leader>Ref", function()
  refactor.refactor("Extract Function To File")
end, { desc = "V Extract Function to File" })

-- Extract variable supports only Visual mode
vim.keymap.set("x", "<leader>Rev", function()
  refactor.refactor("Extract Variable")
end, { desc = "V Extract Variable" })

-- Inline func supports only Normal
vim.keymap.set("n", "<leader>Rif", function()
  refactor.refactor("Inline Function")
end, { desc = "N Inline Function" })

-- Inline var supports both Normal and Visual mode
vim.keymap.set({ "n", "x" }, "<leader>Riv", function()
  refactor.refactor("Inline Variable")
end, { desc = "N,X Inline Variable" })

-- Extract block supports only Normal mode
vim.keymap.set("n", "<leader>Rbe", function()
  refactor.refactor("Extract Block")
end, { desc = "N Extract Block" })
vim.keymap.set("n", "<leader>Rbf", function()
  refactor.refactor("Extract Block To File")
end, { desc = "N Extract Block to File" })

-- Prompt for a refactor to apply when the remap is triggered
vim.keymap.set({ "n", "x" }, "<leader>Rn", function()
  refactor.select_refactor()
end, { desc = "N,X Refactoring using in-built Neovim" })
-- Note that not all refactor support both Normal and Visual mode

-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

vim.keymap.set({ "n", "x" }, "<leader>Rt", function()
  require("telescope").extensions.refactoring.refactors()
end, { desc = "N,X Refactoring using Telescope" })

-- You can also use below = true here to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
vim.keymap.set("n", "<leader>Rp", function()
  refactor.debug.printf({ below = false })
end, { desc = "N Print Debug" })

-- Print Var
-- Supports both Normal and Visual mode
vim.keymap.set({ "x", "n" }, "<leader>Rv", function()
  require("refactoring").debug.print_var()
end, { desc = "N,X Print Variable" })

-- Supports only Normal mode
vim.keymap.set("n", "<leader>Rc", function()
  refactor.debug.cleanup({})
end, { desc = "N Clean Debug" })
-- Refactoring Keymaps

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
