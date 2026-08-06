return {
  -- 额外的配色方案（在 <leader>uC 里可实时预览对比）
  { "sainnhe/gruvbox-material", lazy = true, priority = 1000 },
  { "rebelot/kanagawa.nvim", lazy = true, priority = 1000 },
  { "Mofiqul/vscode.nvim", lazy = true, priority = 1000 },
  { "EdenEast/nightfox.nvim", lazy = true, priority = 1000 },

  -- 当前启用的配色
  { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox-material" } },
}
