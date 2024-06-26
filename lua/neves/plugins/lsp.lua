return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local cmp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp.default_capabilities())
        require("mason").setup({
            ui = {
                border = 'rounded',
            },
        })

        require('lspconfig').gdscript.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                require('nvim-navic').attach(client, bufnr)
            end,
            root_dir = require('lspconfig.util').root_pattern('project.godot', '.git'),
            cmd = { 'ncat', '127.0.0.1', '6005' },
            flags = {
                debounce_text_changes = 150,
            }
        })

        require('lspconfig.ui.windows').default_options.border = 'rounded'

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover, {
                border = 'rounded'
            }
        )
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help, {
                border = 'rounded'
            }
        )
        require("mason-lspconfig").setup({
            sync_install = true,
            auto_install = true,
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            -- if client.server_capabilities.documentSymbolProvider then
                            require('nvim-navic').attach(client, bufnr)
                            -- end
                        end
                        -- border in float

                    })
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    }
                end,
                ['pylsp'] = function()
                    require("lspconfig").pylsp.setup({
                        capabilities = capabilities,
                        settings = {
                            pylsp = {
                                plugins = {
                                    pycodestyle = {
                                        enabled = false
                                    },
                                    autopep8 = {
                                        enabled = false
                                    },
                                    yapf = {
                                        enabled = false
                                    },
                                }
                            }
                        }
                    })
                end,
            },
        })
        require("fidget").setup()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('LspConfig', {}),
            callback = function(ev)
                local opts = { buffer = ev.buffer }
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end,
        })
    end,
}
