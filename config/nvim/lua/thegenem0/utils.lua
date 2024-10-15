local M = {}

-- Function to set key mappings
function M.keymap(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

function M.get_augroup(client)
    if not M.augroups[client.id] then
        local group_name = 'lsp-autoformat-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        M.augroups[client.id] = id
    end

    return M.augroups[client.id]
end

return M
