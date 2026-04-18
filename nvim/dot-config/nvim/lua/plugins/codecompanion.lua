-- lua/plugins/codecompanion.lua
return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.6.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "MeanderingProgrammer/render-markdown.nvim", opts = true },
      -- Temporarily commented out because it's causing the nil error
      { "ttgrules/cc-adapter-copilot-cli-acp" },
    },

    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },

    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI: Toggle Chat", mode = { "n", "v" } },
      { "<leader>cp", "<cmd>CodeCompanionActions<cr>", desc = "AI: Action Palette", mode = { "n", "v" } },
      { "<leader>ci", "<cmd>CodeCompanion<cr>", desc = "AI: Inline Edit", mode = "v" },
      { "<leader>ce", "<cmd>CodeCompanion /explain<cr>", desc = "AI: Explain", mode = "v" },
      { "<leader>cr", "<cmd>CodeCompanion /refactor<cr>", desc = "AI: Refactor", mode = "v" },
      { "<leader>cf", "<cmd>CodeCompanion /fix<cr>", desc = "AI: Fix", mode = "v" },
      { "<leader>cx", "<cmd>CodeCompanionChat Add<cr>", desc = "AI: Add to Chat", mode = "v" },
    },

    config = function()
      require("codecompanion").setup {
        adapters = {
          copilot = {},

          copilot_cli = { -- ACP agent using your installed Copilot CLI
            name = "copilot_cli",
            cmd = "copilot",
          },
        },

        interactions = {
          chat = {
            adapter = "copilot",
          },

          inline = { adapter = "copilot" },
          background = { adapter = "copilot" },

          -- Disable the unstable external CLI agent for now (this removes the nil error)
          cli = { enabled = true, adaper = "copilot_cli" },
          agent = {
            enabled = true,
            adapter = "copilot", -- Use built-in agent tools with Copilot
          },
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
      }

      require("render-markdown").setup {
        file_types = { "markdown", "codecompanion" },
      }
    end,
  },
}
