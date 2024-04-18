return {
    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.6',
        dependencies = { "nvim-lua/plenary.nvim" },

        config = function()
            require('telescope').setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git", ".rf", ".cache", ".png", ".jpg", ".jpeg", ".mp4", ".avi", ".pyd", ".whl", ".pkl", "dist" },
                    hidden_files = true,
                    search_by = { "title", "path" },
                    order_by = "desc",
                    display_type = "full",
                    layout_config = {
                        prompt_position = "bottom",
                        width = 0.75,
                        height = 0.75,
                        horizontal = { width = 0.75, height = 0.75 },
                        vertical = { width = 0.75, height = 0.75 },
                        flex = { width = 0.75, height = 0.75 }
                    }
                }
            })

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>pw', function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end)
            vim.keymap.set('n', '<leader>pW', function() builtin.grep_string({ search = vim.fn.expand("<cWORD>") }) end)
            vim.keymap.set('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)
            vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        end
    },
    {
        "nvim-telescope/telescope-project.nvim",
        config = function()
            require('telescope').setup({
                extensions = {
                    project = {
                        hidden_files = true,
                        theme = "dropdown",
                        order_by = "desc",
                        search_by = { "title", "path" },
                        display_type = "full",
                        sync_with_nvim_tree = true,
                        on_project_selected = function(prompt_bufnr)
                            local project_actions = require("telescope._extensions.project.actions")
                            project_actions.change_working_directory(prompt_bufnr, false)
                            -- harpoon
                            require("harpoon.ui").nav_file(1)

                            -- -- harpoon2
                            -- local harpoon = require("harpoon")
                            -- harpoon:setup()
                            -- harpoon:list():select(1)
                        end
                    }
                }
            })
            require('telescope').load_extension('project')
            vim.api.nvim_set_keymap('n', '<leader>pm', ":lua require'telescope'.extensions.project.project{}<CR>",
                { noremap = true, silent = true })
        end
    }
}
