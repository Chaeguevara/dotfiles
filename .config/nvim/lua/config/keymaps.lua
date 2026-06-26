-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- tmux sessions from within nvim (nvim keeps running in the original session)
-- <leader>tn → create + switch to a named tmux session
vim.keymap.set("n", "<leader>tn", function()
  if vim.env.TMUX == nil then
    vim.notify("Not inside tmux", vim.log.levels.WARN)
    return
  end
  local name = vim.fn.input("New tmux session: ")
  if name ~= "" then
    name = vim.fn.shellescape(name)
    vim.fn.system("tmux new-session -d -s " .. name)
    vim.fn.system("tmux switch-client -t " .. name)
  end
end, { desc = "tmux: new named session" })

-- <leader>tf → fuzzy project session switcher (tmux-sessionizer popup)
vim.keymap.set("n", "<leader>tf", function()
  if vim.env.TMUX == nil then
    vim.notify("Not inside tmux", vim.log.levels.WARN)
    return
  end
  vim.fn.system("tmux display-popup -E -w 60% -h 50% '~/dotfiles/bin/tmux-sessionizer'")
end, { desc = "tmux: project sessionizer" })
