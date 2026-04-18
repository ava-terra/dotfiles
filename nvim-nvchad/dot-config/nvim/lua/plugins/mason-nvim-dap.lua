---@type NvPluginSpec
return {
  "jay-babu/mason-nvim-dap.nvim",
  -- ft = "python",
  keys = {
    { "<leader>d", desc = "Load DAP" },
  },
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  opts = {
    automatic_installation = true,

    ensure_installed = { "codelldb", "python", "delve", "golang" }, -- installs the debug adapters if not installed
    handlers = {}, -- sets up dap in the predefined manner
  },
}
