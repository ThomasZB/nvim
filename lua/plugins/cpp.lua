return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          -- 注意: 这个 keys 列表会整体替换 LazyVim 的默认值,
          -- 所以要把原有的 <leader>ch 一并写进来
          keys = {
            { "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
            -- Option+O 在 .h 和 .cc/.cpp 之间切换 (对标 VSCode 的 Alt+O)
            -- 仅在 clangd 挂载的缓冲区生效, 不影响其他语言
            { "<M-o>", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
        },
      },
    },
  },
}
