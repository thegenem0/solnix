return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>ts",
            "<cmd>Trouble symbols toggle pinned=true win.relative=win win.position=right<cr>",
            desc = "Symbols",
        },
        {
            "<leader>tr",
            "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
    },
}
