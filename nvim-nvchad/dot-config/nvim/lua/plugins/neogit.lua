-- lua/plugins/neogit.lua
return {
  {
    "NeogitOrg/neogit",

    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Pick only one picker
      "nvim-telescope/telescope.nvim", -- recommended
      -- "ibhagwan/fzf-lua",             -- alternative
      -- "echasnovski/mini.pick",        -- alternative
    },

    keys = {
      { "<leader>G", "<cmd>Neogit<CR>", desc = "Open Neogit" },
    },

    opts = {
      auto_refresh = true,
      -- use_magit_keybindings = true,   -- uncomment if you want magit-style bindings

      -- You can add more options here as needed
      -- integrations = {
      --   diffview = true,
      --   telescope = true,
      -- },
    },

    config = function(_, opts)
      require("neogit").setup(opts)
    end,
  },
}
