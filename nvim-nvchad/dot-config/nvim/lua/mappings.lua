require "nvchad.mappings"

-- Add your custom mappings here
local map = vim.keymap.set

-- ====================== General Mappings ======================
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")

-- ====================== Debug (DAP) Mappings ======================
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "DAP: Toggle Breakpoint" })
map("n", "<leader>dpr", function()
  require("dap-python").test_method()
end, { desc = "DAP: Python Run Test Method" })
map("n", "<leader>dr", "<cmd>DapContinue<CR>", { desc = "DAP: Continue" })
