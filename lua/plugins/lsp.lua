return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "antosha417/nvim-lsp-file-operations", config = true },
    {
      "b0o/SchemaStore.nvim",
      version = false, -- last release is way too old
    },
    { "jose-elias-alvarez/typescript.nvim" },
  },
  -- setup = {},
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Goto Declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Goto Definition"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Goto Implementation"
      keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gT", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart Rename"
      keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show Buffer Diagnostics"
      keymap.set("n", "<leader>xD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show Line Diagnostics"
      keymap.set("n", "<leader>xd", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to Previous Diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to Next Diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>cR", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    -- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    -- for type, icon in pairs(signs) do
    --   local hl = "DiagnosticSign" .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    -- end

    -- configure clangd server
    lspconfig["clangd"].setup({
      clangd = function(_, opts)
        local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
        require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
        return true
      end,
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
      on_attach = on_attach,
      keys = {
        { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
      },
      root_dir = function(...)
        -- using a root .clang-format or .clang-tidy file messes up projects, so remove them
        return require("lspconfig.util").root_pattern(
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac",
          ".git"
          )(...)
      end,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    })

    -- configure css server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure emmet language server
    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    -- configure eslint server
    lspconfig["eslint"].setup({
      eslint = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
          callback = function(event)
            if not require("lazyvim.plugins.lsp.format").enabled() then
              -- exit early if autoformat is not enabled
              return
            end
            local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
            if client then
              local diag = vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
              if #diag > 0 then
                vim.cmd("EslintFixAll")
              end
            end
          end,
        })
      end,
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
        workingDirectory = { mode = "auto" },
      },
    })

    -- configure gopls server
    lspconfig["gopls"].setup({
      gopls = function()
        -- workaround for gopls not supporting semanticTokensProvider
        -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
        require("lazyvim.util").on_attach(function(client, _)
          if client.name == "gopls" then
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end
        end)
        -- end workaround
      end,
      capabilities = capabilities,
      on_attach = on_attach,
      keys = {
        -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
        { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
      },
      settings = {
        gopls = {
          gofumpt = true,
          codelenses = {
            gc_details = false,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          analyses = {
            fieldalignment = true,
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
          semanticTokens = true,
        },
      },
    })

    -- configure graphql language server
    lspconfig["graphql"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    -- configure html server
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure jdtls server
    lspconfig["jdtls"].setup({
      -- Override the default jdtls server startup to use nvim-jdtls.
      jdtls = function()
        -- The lspconfig configuration for jdtls contains two useful items:
        -- 1. The list of filetypes on which to match.
        -- 2. Custom method for finding the root for a java project.
        local lsp_config = require("lspconfig.server_configurations.jdtls").default_config
        local find_java_project_root = lsp_config.root_dir
        local filetypes = lsp_config.filetypes
        -- lookup paths for java test and debugger package
        local mason_registry = require("mason-registry")
        local bundles = {}
        if mason_registry.has_package("java-test") and mason_registry.has_package("java-debug-adapter") then
          -- jdtls tools configuration for debugging support
          local java_test_pkg = mason_registry.get_package("java-test")
          local java_test_path = java_test_pkg:get_install_path()
          local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
          local java_dbg_path = java_dbg_pkg:get_install_path()
          local jar_patterns = {
            java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
            java_test_path .. "/extension/server/*.jar",
          }
          for _, jar_pattern in ipairs(jar_patterns) do
            for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
              table.insert(bundles, bundle)
            end
          end
        end
        -- Attach jdtls for the proper filetypes (i.e. java).
        -- Existing server will be reused if the root_dir matches.
        vim.api.nvim_create_autocmd("FileType", {
          group = vim.api.nvim_create_augroup("MyJdtls", { clear = true }),
          pattern = filetypes,
          callback = function()
            local fname = vim.api.nvim_buf_get_name(0)
            local root_dir = find_java_project_root(fname)
            local project_name = root_dir and vim.fs.basename(root_dir)
            local cmd = { "jdtls" }
            if project_name then
              local jdtls_cache_dir = vim.fs.joinpath(vim.fn.stdpath("cache"), "jdtls", project_name)
              vim.list_extend(cmd, {
                "-configuration",
                vim.fs.joinpath(jdtls_cache_dir, "config"),
                "-data",
                vim.fs.joinpath(jdtls_cache_dir, "workspace"),
              })
            end
            local jdtls_base_config = {
              on_attach = require("lazyvim.util").on_attach(function(client, buffer)
                if mason_registry.has_package("java-test") then
                  -- custom keymaps for Java test runner (not yet compatible with neotest)
                  vim.keymap.set("n", "<leader>tT", function()
                    require("jdtls").pick_test({ bufnr = buffer })
                  end, { buffer = buffer, desc = "Run specific Test" })
                  vim.keymap.set("n", "<leader>tt", function()
                    require("jdtls").test_class({ bufnr = buffer })
                  end, { buffer = buffer, desc = "Run File" })
                  vim.keymap.set("n", "<leader>tr", function()
                    require("jdtls").test_nearest_method({ bufnr = buffer })
                  end, { buffer = buffer, desc = "Run nearest" })
                end
                if mason_registry.has_package("java-debug-adapter") then
                  -- custom init for Java debugger
                  require("jdtls").setup_dap({ hotcodereplace = "auto" })
                  require("jdtls.dap").setup_dap_main_class_configs()
                end
                require("jdtls.setup").add_commands()
              end),
              cmd = cmd,
              root_dir = root_dir,
              init_options = {
                bundles = bundles,
              },
            }
            local jdtls_opts = require("lazyvim.util").opts("nvim-jdtls")
            require("jdtls").start_or_attach(vim.tbl_deep_extend("force", jdtls_opts or {}, jdtls_base_config))
            require("which-key").register({ c = { x = { name = "Extract" } } }, { prefix = "<leader>" })
          end,
        })
        return true -- avoid duplicate servers
      end,
      capabilities = capabilities,
      on_attach = on_attach,
      -- stylua: ignore
      keys = {
        { "<leader>co", function() require("jdtls").organize_imports() end, desc = "Organize Imports", },
        { "<leader>cR", function() require("jdtls").rename_file() end, desc = "Rename File", },
        { "<leader>cxv", function() require("jdtls").extract_variable() end, desc = "Extract Variable", },
        { "<leader>cxv", function() require("jdtls").extract_variable({ visual = true }) end, mode = "v", desc = "Extract Variable", },
        { "<leader>cxc", function() require("jdtls").extract_constant() end, desc = "Extract Constant", },
        { "<leader>cxc", function() require("jdtls").extract_constant({ visual = true }) end, mode = "v", desc = "Extract Constant", },
        { "<leader>cxm", function() require("jdtls").extract_method({ visual = true }) end, mode = "v", desc = "Extract Method", },
      },
    })

    -- configure jsonls server
    lspconfig["jsonls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      -- lazy-load schemastore when needed
      on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      end,
      settings = {
        json = {
          format = {
            enable = true,
          },
          validate = { enable = true },
        },
      },
    })

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- configure prisma orm server
    lspconfig["prismals"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure python server
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure rust_analyzer server
    lspconfig["rust_analyzer"].setup({
      rust_analyzer = function(_, opts)
        local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
        require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
        return true
      end,
      capabilities = capabilities,
      on_attach = on_attach,
      keys = {
        { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
        { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
        { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
      },
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true,
          },
          -- Add clippy lints for Rust.
          checkOnSave = {
            allFeatures = true,
            command = "clippy",
            extraArgs = { "--no-deps" },
          },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
        },
      },
      taplo = {
        keys = {
          {
            "K",
            function()
              if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                require("crates").show_popup()
              else
                vim.lsp.buf.hover()
              end
            end,
            desc = "Show Crate Documentation",
          },
        },
      },
    })

    -- configure svelte server
    lspconfig["svelte"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure tailwindcss server
    lspconfig["tailwindcss"].setup({
      tailwindcss = function(_, opts)
        local tw = require("lspconfig.server_configurations.tailwindcss")
        --- @param ft string
        opts.filetypes = vim.tbl_filter(function(ft)
          return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
        end, tw.default_config.filetypes)
      end,
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes_exclude = { "markdown" },
    })

    -- configure typescript server with plugin
    lspconfig["tsserver"].setup({
      tsserver = function(_, opts)
        require("typescript").setup({ server = opts })
        return true
      end,
      capabilities = capabilities,
      on_attach = on_attach,
      keys = {
        { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
        { "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
      },
      settings = {
        typescript = {
          format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
          },
        },
        javascript = {
          format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
          },
        },
        completions = {
          completeFunctionCalls = true,
        },
      },
    })
  end,
}
