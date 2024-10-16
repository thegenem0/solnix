local utils = require("solinaire.utils")

return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({})
            utils.keymap("n", "<leader>e", ":Neotree toggle<cr>", { desc = "Toggle Explorer" })
        end,
    },
}