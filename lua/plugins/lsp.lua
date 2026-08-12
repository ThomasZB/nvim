return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- 默认关闭内嵌提示(函数参数名), 需要时按 <leader>uh 临时打开
      inlay_hints = { enabled = false },
    },
  },
}
