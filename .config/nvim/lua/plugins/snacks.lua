-- Show dotfiles (e.g. .gitignore, .env.example) in the Snacks explorer by default.
-- Toggle at runtime with `H` (hidden) and `I` (gitignored) while the tree is focused.
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- dotfiles visible (.gitignore shows up)
          -- ignored = true, -- uncomment to also show gitignored files (node_modules, .env)
        },
      },
    },
  },
}
