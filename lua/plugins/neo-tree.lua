return {
  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    module = "neo-tree",
    cmd = "Neotree",
    dependencies = { { "MunifTanjim/nui.nvim", module = "nui" }, "nvim-lua/plenary.nvim" },
    opts = {
      close_if_last_window = true,
      enable_diagnostics = false,
      source_selector = {
        winbar = true,
        content_layout = "center",
        tab_labels = {
          filesystem = " File",
          buffers = "➜ Buffs",
          git_status = " Git",
          diagnostics = "",
        },
      },
      default_component_configs = {
        indent = {
          padding = 0,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
        },
        git_status = {
          symbols = {
            added = "",
            deleted = "",
            modified = "",
            renamed = "",
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        width = 30,
        mappings = {
          ["o"] = "open",
          ["v"] = "open_vsplit",
        },
      },
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(_)
            vim.opt_local.signcolumn = "auto"
          end,
        },
      },
    },
  },
}
