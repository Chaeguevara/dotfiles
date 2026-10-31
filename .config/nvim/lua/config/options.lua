-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- macOS SDK compatibility: ensure native parser/plugin builds (nvim-treesitter, etc.)
-- target the running macOS version rather than a newer installed Xcode/CLT SDK version,
-- and fall back to CommandLineTools SDK if xcrun fails on another Mac.
if vim.fn.has("mac") == 1 then
  if not vim.env.MACOSX_DEPLOYMENT_TARGET or vim.env.MACOSX_DEPLOYMENT_TARGET == "" then
    local ver = vim.fn.systemlist("sw_vers -productVersion")[1]
    if vim.v.shell_error == 0 and ver and ver ~= "" then
      vim.env.MACOSX_DEPLOYMENT_TARGET = ver
    end
  end
  if not vim.env.SDKROOT or vim.env.SDKROOT == "" then
    vim.fn.system("xcrun --show-sdk-path")
    if vim.v.shell_error ~= 0 then
      local clt_sdk = "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
      if (vim.uv or vim.loop).fs_stat(clt_sdk) then
        vim.env.SDKROOT = clt_sdk
      end
    end
  end
end

-- Minimal chrome: hide the ~ end-of-buffer column
vim.opt.fillchars:append({ eob = " " })
