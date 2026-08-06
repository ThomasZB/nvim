-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- <leader>f 打开文件搜索
-- 注意: <leader>f 同时是 LazyVim 的 file/find 前缀 (如 <leader>ff),
-- 所以按下后会等待约 300ms 确认没有后续按键才触发
vim.keymap.set("n", "<leader>f", function()
  Snacks.picker.files()
end, { desc = "Find Files" })

-- jj 退出 insert 模式
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- 文件浏览器的快捷键定义在 lua/plugins/explorer.lua
-- (需要覆盖 snacks.nvim 插件自带的 keys, 写在插件 spec 里才可靠)
