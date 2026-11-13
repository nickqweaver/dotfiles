return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    input = { enabled = true },
    picker = { enabled = true },
    -- Configures lazygit with editPreset "nvim-remote", so `e` / `o` on a file
    -- closes the float and opens it in this nvim instead of a nested nvim.
    lazygit = { enabled = true },
  },
  keys = {
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Open lazy git" },
  },
}
