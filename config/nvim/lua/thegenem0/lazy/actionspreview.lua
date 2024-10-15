local utils = require("thegenem0.utils")

return {
    "aznhe21/actions-preview.nvim",
    config = function()
        local preview = require("actions-preview")
        utils.keymap("n", "<leader>ca", preview.code_actions, { desc = "Code Actions" })
    end,
}
