return {
    {
        'folke/trouble.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('trouble').setup({
                win_config = { border = "rounded" },
            })
            vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle("diagnostics") end)
            vim.keymap.set("n", "<leader>tn",
                function() require("trouble").next({ mode = "diagnostics", skip_groups = true, jump = true }) end)
            vim.keymap.set("n", "<leader>tp",
                function() require("trouble").prev({ mode = "diagnostics", skip_groups = true, jump = true }) end)
            vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("quickfix") end)
            vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end)
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
