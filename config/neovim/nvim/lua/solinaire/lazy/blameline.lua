return {
    "braxtons12/blame_line.nvim",
    config = function()
        require("blame_line").setup({
            show_in_visual = false,
            show_in_insert = false,
            delay = 1000,
        })
    end
}
