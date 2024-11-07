function SetMyColors(color)
    color = color or "dracula"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        {
            'xiyaowong/transparent.nvim',

            config = function()
                local transparent = require("transparent")
                transparent.setup {
                    extra_groups = {
                        'help',
                        'terminal',
                        'dashboard',
                    },
                    transparent_background = true,
                    transparent_floating_windows = false,
                }

                transparent.clear_prefix("BufferLine")
                transparent.clear_prefix("NeoTree")
                transparent.clear_prefix("Telescope")
            end
        },
        {
            "Mofiqul/dracula.nvim",
            config = function()
                SetMyColors()
            end
        }
    }
}
