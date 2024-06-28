return {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local gitsigns = require('gitsigns')
        gitsigns.setup {
            signs                        = {
                add          = { text = '│' },
                change       = { text = '│' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn                   = true,
            numhl                        = false,
            linehl                       = false,
            word_diff                    = false,
            watch_gitdir                 = {
                follow_files = true
            },
            auto_attach                  = true,
            attach_to_untracked          = false,
            current_line_blame           = false,
            current_line_blame_opts      = {
                virt_text = true,
                virt_text_pos = 'eol',
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority                = 6,
            update_debounce              = 100,
            status_formatter             = nil,
            max_file_length              = 40000,
            preview_config               = {
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            yadm                         = {
                enable = false
            },
        }

        -- Navigation
        vim.keymap.set('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end, { noremap = true })

        vim.keymap.set('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end, { noremap = true })

        -- Actions
        vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { noremap = true })
        vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { noremap = true })
        vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { noremap = true })
        vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { noremap = true })
        vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { noremap = true })
        vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, { noremap = true })
        vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { noremap = true })
        vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { noremap = true })
        vim.keymap.set('n', '<C-g>', gitsigns.preview_hunk)
        vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
        vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        vim.keymap.set('n', '<leader>hd', gitsigns.diffthis)
        vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        vim.keymap.set('n', '<leader>td', gitsigns.toggle_deleted)
    end
}
