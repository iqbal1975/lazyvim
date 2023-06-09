return {
  -- File explorer
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v2.x",
  --   module = "neo-tree",
  --   cmd = "Neotree",
  --   dependencies = { { "MunifTanjim/nui.nvim", module = "nui" }, "nvim-lua/plenary.nvim" },
  --   opts = {
  --     close_if_last_window = true,
  --     enable_diagnostics = false,
  --     source_selector = {
  --       winbar = true,
  --       content_layout = "center",
  --     },
  --     default_component_configs = {
  --       indent = {
  --         padding = 0,
  --       },
  --       icon = {
  --         folder_closed = "",
  --         folder_open = "",
  --         folder_empty = "",
  --       },
  --       git_status = {
  --         symbols = {
  --           added = "",
  --           deleted = "",
  --           modified = "",
  --           renamed = "",
  --           untracked = "",
  --           ignored = "",
  --           unstaged = "",
  --           staged = "",
  --           conflict = "",
  --         },
  --       },
  --     },
  --     window = {
  --       width = 30,
  --       mappings = {
  --         ["o"] = "open",
  --         ["v"] = "open_vsplit",
  --       },
  --     },
  --     filesystem = {
  --       follow_current_file = true,
  --       hijack_netrw_behavior = "open_current",
  --       use_libuv_file_watcher = true,
  --       filtered_items = {
  --         visible = true,
  --         hide_dotfiles = false,
  --         hide_gitignored = true,
  --       },
  --     },
  --     event_handlers = {
  --       {
  --         event = "neo_tree_buffer_enter",
  --         handler = function(_)
  --           vim.opt_local.signcolumn = "auto"
  --         end,
  --       },
  --     },
  --   },
  -- },
  {
    opts = function(_, opts)
      opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
        or { "terminal", "Trouble", "qf", "Outline" }
      table.insert(opts.open_files_do_not_replace_types, "edgy")
    end,
  },
}
