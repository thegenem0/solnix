local utils = require("thegenem0.utils")

return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            local toggleterm = require("toggleterm")
            toggleterm.setup({
                direction = "float",
                auto_open = true,
                float_opts = {
                    border = "curved",
                },
                winbar = {
                    enabled = false,
                    name_formatter = function(term) --  term: Terminal
                        return term.name
                    end
                },
            })

            utils.keymap("n", "<leader>tt", ":ToggleTerm direction=float<cr>", { desc = "Toggle Terminal Vertical" })
            utils.keymap("n", "<leader>th", ":ToggleTerm direction=horizontal<cr>", { desc = "Toggle Terminal Horizontal" })
            -- map esc to close exit terminal mode
            vim.cmd([[
            tnoremap <esc> <C-\><C-N>
            ]])
        end,
    },
}
