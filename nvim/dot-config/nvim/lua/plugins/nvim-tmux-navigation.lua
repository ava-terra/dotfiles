-- lua/plugins/tmux-navigation.lua
return {
  "alexghergh/nvim-tmux-navigation",
  event = "VeryLazy",
  cmd = {
    "NvimTmuxNavigateLeft",
    "NvimTmuxNavigateDown",
    "NvimTmuxNavigateUp",
    "NvimTmuxNavigateRight",
    "NvimTmuxNavigateLastActive",
    "NvimTmuxNavigateNext",
  },
  config = function()
    require("nvim-tmux-navigation").setup({
      disable_when_zoomed = true,
      -- No keybindings table here — we handle everything in keymaps.lua
    })
  end,
}
