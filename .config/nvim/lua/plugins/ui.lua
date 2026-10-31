-- Apple-inspired minimal UI: Xcode's own editor palette, flat statusline,
-- no tab strip, no indent guides. Swap "xcodedark" for "xcodelight"/"xcodewwdc".
return {
  { "lunacookies/vim-colors-xcode" },
  { "LazyVim/LazyVim", opts = { colorscheme = "xcodedark" } },

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

  -- blink.cmp: fall back cleanly to pure-Lua fuzzy matching if the prebuilt Rust
  -- .dylib fails to load (dlopen) on a Mac with an older/mismatched macOS SDK.
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.fuzzy = opts.fuzzy or {}
      opts.fuzzy.implementation = "prefer_rust"
      local ok = pcall(require, "blink.cmp.fuzzy.rust")
      if not ok then
        local dylib = vim.fn.stdpath("data") .. "/lazy/blink.cmp/target/release/libblink_cmp_fuzzy.dylib"
        if (vim.uv or vim.loop).fs_stat(dylib) then
          opts.fuzzy.implementation = "lua"
        end
      end
    end,
  },
}
