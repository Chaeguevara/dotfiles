return {
  {
    -- In-buffer rendering: opening a markdown file shows it rendered
    -- automatically (headings, code blocks, tables, lists). Normal mode
    -- renders; insert mode shows raw source so you can edit.
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    init = function()
      vim.g.mkdp_auto_start = 1 -- open browser preview automatically on md open
      vim.g.mkdp_auto_close = 1 -- close preview tab when leaving the md buffer
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown Preview" },
    },
  },
}
