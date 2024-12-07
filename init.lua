-- bootstrap lazy.nvim, LazyVim and your plugins
-- return {
-- require("config.lazy")
-- }

if vim.env.VSCODE then
  vim.g.vscode = true
end

if vim.loader then
  vim.loader.enable()
end

require("config.lazy")
