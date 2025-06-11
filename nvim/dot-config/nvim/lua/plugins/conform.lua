---@type NvPluginSpec
return {

  "stevearc/conform.nvim",
  -- event = 'BufWritePre', -- uncomment for format on save
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = require "configs.conform",
}
