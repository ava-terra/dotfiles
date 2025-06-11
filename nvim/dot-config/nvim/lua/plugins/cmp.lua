---@type NvPluginSpec
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    {
      "zbirenbaum/copilot-cmp",
      config = function()
        require("copilot_cmp").setup()
      end,
    },
  },
  opts = require "configs.cmp",
}
