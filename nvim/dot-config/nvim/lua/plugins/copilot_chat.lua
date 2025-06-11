-- ~/.config/nvim/lua/plugins/copilot_chat.lua
---@type NvPluginSpec
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main", -- Use main branch, as canary is deprecated
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- Ensure copilot.lua is loaded
    { "nvim-lua/plenary.nvim" }, -- Required for async operations
    { "nvim-telescope/telescope.nvim" },
  },
  agents = {
    llama = {
      api_key = "none",
      api_base = "http://ai.janus.lan:11434/api",
      model = "llama3",
      system_prompt = "You are a fast, local code assistant.",
    },
  },
  opts = require "configs.copilot_chat", -- Load config from configs/copilot_chat.lua
  keys = {
    { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "Open Copilot Chat", mode = "n" },
    { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explain selected code", mode = { "n", "v" } },
    { "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "Fix selected code", mode = { "n", "v" } },
  },
}
