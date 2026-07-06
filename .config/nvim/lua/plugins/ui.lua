-- Apple-inspired minimal UI: Xcode's own editor palette, flat statusline,
-- no tab strip, no indent guides. Swap "xcodedark" for "xcodelight"/"xcodewwdc".
return {
  { "lunacookies/vim-colors-xcode" },
  { "LazyVim/LazyVim", opts = { colorscheme = "xcodedark" } },

  -- one buffer on screen, no bufferline tab strip
  { "akinsho/bufferline.nvim", enabled = false },

  -- flat, quiet statusline (no powerline wedges)
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.section_separators = ""
      opts.options.component_separators = ""
    end,
  },

  -- no indent/scope guide lines
  { "folke/snacks.nvim", opts = { indent = { enabled = false } } },
}
