-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Clear Search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { noremap = true, silent = false, desc = "Clear Search" })
-- Clear Search

-- DAP Keymaps
local dk = require("which-key")
dk.register({
  D = {
    name = "+DAP",
    b = {
      name = "+Breakpoints",
    },
    s = {
      name = "+Steps",
    },
    v = {
      name = "+Views",
    },
  },
}, { prefix = "<leader>" })

local dap = require("dap")
local breakpoints = require("dap.breakpoints")
local widgets = require("dap.ui.widgets")

vim.keymap.set("n", "<leader>Dbc", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint" })

vim.keymap.set("n", "<leader>Dbl", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message"))
end, { desc = "Logpoint" })

vim.keymap.set("n", "<leader>Dbr", function()
  breakpoints.clear()
end, { desc = "Remove All" })

vim.keymap.set("n", "<leader>Dbs", "<CMD>Telescope dap list_breakpoints<CR>", { desc = "Show All" })

vim.keymap.set("n", "<leader>Dbt", function()
  dap.toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

vim.keymap.set("n", "<leader>Dc", function()
  dap.continue()
end, { desc = "Continue" })

vim.keymap.set({ "n", "v" }, "<leader>De", function()
  widgets.hover(nil, { border = "none" })
end, { desc = "Evaluate Expression" })

vim.keymap.set("n", "<leader>Dp", function()
  dap.pause()
end, { desc = "Pause" })

vim.keymap.set("n", "<leader>Dr", "<CMD>Telescope dap configurations<CR>", { desc = "Run" })

vim.keymap.set("n", "<leader>Dsb", function()
  dap.step_back()
end, { desc = "Step Back" })

vim.keymap.set("n", "<leader>Dsc", function()
  dap.run_to_cursor()
end, { desc = "Run to Cursor" })

vim.keymap.set("n", "<leader>Dsi", function()
  dap.step_into()
end, { desc = "Step Into" })

vim.keymap.set("n", "<leader>Dso", function()
  dap.step_over()
end, { desc = "Step Over" })

vim.keymap.set("n", "<leader>Dsx", function()
  dap.step_out()
end, { desc = "Step Out" })

vim.keymap.set("n", "<leader>Dx", function()
  dap.terminate()
end, { desc = "Terminate" })

vim.keymap.set("n", "<leader>Dvf", function()
  widgets.centered_float(widgets.frames, { border = "none" })
end, { desc = "Show Frames" })

vim.keymap.set("n", "<leader>Dvr", function()
  dap.repl.open(nil, "20split")
end, { desc = "Show Repl" })

vim.keymap.set("n", "<leader>Dvs", function()
  widgets.centered_float(widgets.scopes, { border = "none" })
end, { desc = "Show Scopes" })

vim.keymap.set("n", "<leader>Dvt", function()
  widgets.centered_float(widgets.threads, { border = "none" })
end, { desc = "Show Threads" })
-- DAP Keymaps

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
