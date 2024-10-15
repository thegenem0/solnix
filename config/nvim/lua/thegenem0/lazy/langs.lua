return {
    "olexsmir/gopher.nvim",
    config = function()
        require("gopher").setup({
            ft = { "go" },
            goimport = 'gopls',
            gofmt = 'gopls',
            max_line_len = 120,
            impl = "impl",
            iferr = "iferr",
        })
    end,
}
