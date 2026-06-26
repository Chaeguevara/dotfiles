-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Make the split divider (WinSeparator) clearly visible.
-- Re-applied on every ColorScheme so it survives theme switches.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("win_separator_contrast", { clear = true }),
  callback = function()
    -- Brighter line; use a strong grey that reads on both light & dark themes.
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7c8088", bold = true })
  end,
})

-- Use a solid line character for the divider instead of the default.
vim.opt.fillchars:append({ horiz = "─", vert = "│", horizup = "┴", horizdown = "┬", vertleft = "┤", vertright = "├", verthoriz = "┼" })

-- Apply immediately for the current session (ColorScheme already fired at startup).
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7c8088", bold = true })
