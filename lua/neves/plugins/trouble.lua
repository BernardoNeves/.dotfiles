return {
    {
        'folke/trouble.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('trouble').setup({
                icons = true,
                win_config = { border = "rounded" },
            })
            vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
            vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
            vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
            vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
            vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
            vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)


            local signs = { Error = "", Warn = "", Hint = "", Info = "", Other = "" }
            vim.diagnostic.config({ virtual_text = true })
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
}
