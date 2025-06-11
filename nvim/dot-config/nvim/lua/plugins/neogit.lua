---@type NvPluginSpec
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    -- "ibhagwan/fzf-lua",              -- optional
    -- "echasnovski/mini.pick",         -- optional
  },
  config = true,
  keys = {
    { "<leader>G", "<cmd>Neogit<CR>", desc = "Open neogit" },
  },
  opts = {
    -- use_magit_keybindings = true,
    auto_refresh = true,
  },
}
