return {
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('bufferline').setup {
                options = {
                    numbers = 'none',
                    offsets = {
                        {
                            filetype = 'NeoTree',
                            text = 'File Explorer',
                            text_align = 'left',
                            padding = 1,
                            color = 'transparent',
                            hl = 'Directory',
                        },
                    },
                },
            }
        end,
    }
}
