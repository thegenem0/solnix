local utils = require("thegenem0.utils")

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ['<C-j>'] = require('telescope.actions').move_selection_next,
                        ['<C-k>'] = require('telescope.actions').move_selection_previous,
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
            }
        }

        local builtin = require('telescope.builtin')

        utils.keymap('n', '<leader>fr', builtin.oldfiles, { desc = '[?] Find recently opened files' })
        utils.keymap('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        utils.keymap('n', '<leader>fs', builtin.live_grep, { desc = '[F]ind [S]trings' })
        utils.keymap('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    end
}
