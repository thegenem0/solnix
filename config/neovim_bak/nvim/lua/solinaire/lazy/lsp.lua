-- LSP Configuration & Plugins
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "stevearc/conform.nvim",
    },


    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local conform = require("conform")
        local util = require("lspconfig/util")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        local function get_python_path(workspace)
            -- Use activated virtualenv.
            if vim.env.VIRTUAL_ENV then
                return util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
            end

            -- Find and use virtualenv in workspace directory.
            for _, pattern in ipairs({ '*', '.*' }) do
                local match = vim.fn.glob(util.path.join(workspace, pattern, 'pyvenv.cfg'))
                if match ~= '' then
                    return util.path.join(util.path.dirname(match), 'bin', 'python')
                end
            end

            -- Fallback to system Python.
            return exepath('python3') or exepath('python') or 'python'
        end

        require("fidget").setup()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "gopls",
                "lua_ls",
                "eslint",
                "pyright",
                "zls",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ['lua_ls'] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" }
                                }
                            },
                        }
                    }
                end,

                ["eslint"] = function()
                    local lspconfig = require("lspconfig")

                    lspconfig.eslint.setup {
                        capabilities = capabilities,
                        root_dir = util.root_pattern(".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", "package.json", "tsconfig.json"),
                        settings = {
                            workingDirectory = { mode = "auto" },
                        },
                        on_attach = function(_, bufnr)
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = bufnr,
                                command = "EslintFixAll",
                            })
                        end,
                    }
                end,

                ["zls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup {
                        capabilities = capabilities,
                        settings = {
                            zls = {
                                Zls = {
                                    enableAutofix = true,
                                    enable_snippets = true,
                                    enable_ast_check_diagnostics = true,
                                    enable_autofix = true,
                                    enable_import_embedfile_argument_completions = true,
                                    warn_style = true,
                                    enable_semantic_tokens = true,
                                    enable_inlay_hints = true,
                                    inlay_hints_hide_redundant_param_names = true,
                                    inlay_hints_hide_redundant_param_names_last_token = true,
                                    operator_completions = true,
                                    include_at_in_builtins = true,
                                    max_detail_length = 1048576,
                                },
                            },
                        },
                    }
                end,

                ["pyright"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup {
                        before_init = function(_, config)
                            config.settings.python.pythonPath = get_python_path(config.root_dir)
                        end,
                        capabilities = capabilities,
                    }
                end,
            },
        })

        -- Conform formatting
        conform.setup()

        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(args)
                conform.format {
                    bufnr = args.buf,
                    lsp_fallback = true,
                    quiet = true,
                }
            end,
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                --                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                --                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
