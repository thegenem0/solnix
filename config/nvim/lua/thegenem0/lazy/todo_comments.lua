local utils = require("thegenem0.utils")

return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = true, -- show icons in the signs column
            colors = {
                error = { "#DC2626" },
                warning = { "#FBBF24" },
                info = { "#2563EB" },
                hint = { "#10B981" },
                default = { "#7C3AED" },
                test = { "#FF00FF" }
            },
        },
        utils.keymap("n", "<leader>fc", ":TodoTelescope<CR>", { desc = "[F]ind [C]omments" })
    }
}
