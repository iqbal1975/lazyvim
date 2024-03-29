return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    -- put any other flags you wanted to pass to lazy here!
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
      require("neorg").setup({
        -- put any of your previous config here
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.keybinds"] = {}, -- Adds default keybindings
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          }, -- Enables support for completion plugins
          ["core.journal"] = {}, -- Enables support for the journal module
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                work = "~/Neorg/work",
                home = "~/Neorg/home",
              },
            },
          },
        },
      })
    end,
  },
}
