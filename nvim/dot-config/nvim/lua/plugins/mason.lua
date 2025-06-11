---@type NvPluginSpec
return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "black",
      "my-py",
      "ruff",
    },
  },
}
