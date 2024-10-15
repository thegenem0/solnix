-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

vim.o.tabstop = 4       -- 4 spaces for tabs (prettier default)
vim.o.shiftwidth = 4    -- 4 spaces for indent width
vim.o.expandtab = true  -- expand tab to spaces
vim.o.autoindent = true -- copy indent from current line when starting new one

-- Save undo history
vim.o.undofile = true

-- vim.o.relativenumber = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- backspace
vim.o.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
vim.o.splitright = true       -- split vertical window to the right
vim.o.splitbelow = true       -- split horizontal window to the bottom
--
vim.opt.iskeyword:append("-") -- consider string-string as whole word

vim.g.sonokai_style = 'andromeda'
vim.g.sonokai_better_performance = 1

vim.filetype.add({
    extension = {
        ['http'] = 'http',
    },
})
