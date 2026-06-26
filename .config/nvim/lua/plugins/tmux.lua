-- Seamless navigation between Neovim splits and tmux panes.
-- Ctrl-h/j/k/l moves the cursor across both as if they were one grid.
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to left pane/split" },
    { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go to lower pane/split" },
    { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go to upper pane/split" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to right pane/split" },
  },
}
