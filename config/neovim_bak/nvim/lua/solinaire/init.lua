require("solinaire.opts")
require("solinaire.remap")
require("solinaire.lazy_init")

local utils = require("solinaire.utils")
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local SolinaireGroup = augroup("Solinaire", { clear = true })

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
    group = SolinaireGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Attach LSP Keymaps
autocmd("LspAttach", {
    group = SolinaireGroup,
    callback = function(args)
        local bufnr = args.buf
        local opts = function(desc)
            return { buffer = bufnr, desc = desc }
        end

        utils.keymap("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts("[G]o to [D]efinition"))
        utils.keymap("n", "K", function() vim.lsp.buf.hover() end, opts("Hover Documentation"))
        utils.keymap("n", "<leader>sb", function() vim.lsp.buf.workspace_symbol() end, opts("Workspace [S]ym[b]ol"))
        utils.keymap("n", "<leader>fr", function() vim.lsp.buf.references() end, opts("[F]ind [R]eferences"))
        utils.keymap("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts("[R]e[n]ame"))
        utils.keymap("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts("Signature [H]elp"))
        utils.keymap("n", "<C-j>", function() vim.diagnostic.goto_next() end, opts("Next Diagnostic"))
        utils.keymap("n", "<C-k>", function() vim.diagnostic.goto_prev() end, opts("Previous Diagnostic"))
    end,
})
