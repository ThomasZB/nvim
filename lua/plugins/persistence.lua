return {
  {
    "folke/persistence.nvim",
    opts = {},
    -- init 在启动时就执行, 不受插件懒加载影响
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
        nested = true, -- 让恢复出来的缓冲区能正常触发 FileType 等事件 (LSP/高亮才会挂载)
        callback = function()
          -- 只在"不带参数启动"时恢复; 带文件名启动 (nvim foo.cc) 或
          -- 管道输入 (cat x | nvim -) 时保持原样, 避免覆盖用户意图
          if vim.fn.argc() > 0 or vim.g.started_with_stdin then
            return
          end
          vim.schedule(function()
            require("persistence").load()
          end)
        end,
      })

      -- 标记是否从 stdin 读入
      vim.api.nvim_create_autocmd("StdinReadPre", {
        group = "restore_session",
        callback = function()
          vim.g.started_with_stdin = true
        end,
      })
    end,
  },
}
