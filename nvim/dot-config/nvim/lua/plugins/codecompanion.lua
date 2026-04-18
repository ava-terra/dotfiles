-- lua/plugins/codecompanion.lua
return {
  {
    "olimorris/codecompanion.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "MeanderingProgrammer/render-markdown.nvim", opts = true },
    },

    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },

    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI: Toggle Chat", mode = { "n", "v" } },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", desc = "AI: Action Palette", mode = { "n", "v" } },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "AI: Inline Edit", mode = "v" },
      { "<leader>ae", "<cmd>CodeCompanion /explain<cr>", desc = "AI: Explain", mode = "v" },
      { "<leader>ar", "<cmd>CodeCompanion /refactor<cr>", desc = "AI: Refactor", mode = "v" },
      { "<leader>af", "<cmd>CodeCompanion /fix<cr>", desc = "AI: Fix", mode = "v" },
      { "<leader>ax", "<cmd>CodeCompanionChat Add<cr>", desc = "AI: Add to Chat", mode = "v" },
    },

    opts = {
      adapters = {
        copilot = {},
      },

      interactions = {
        chat = {
          adapter = "copilot",
        },
        inline = { adapter = "copilot" },
        background = { adapter = "copilot" },

        cli = { enabled = false },
        agent = { enabled = false },
      },

      opts = {
        log_level = "WARN",
      },

      display = {
        chat = {
          window = { layout = "vertical" },
          show_token_count = true,
        },
        diff = {
          enabled = true,
          close_chat_on_apply = true,
        },
      },
    },

    config = function(_, opts)
      require("codecompanion").setup(opts)

      require("render-markdown").setup {
        file_types = { "markdown", "codecompanion" },
      }
    end,
  },
}
