-- 取当前的 explorer picker (未打开则返回 nil)
local function get_explorer()
  local p = Snacks.picker.get({ source = "explorer" })[1]
  if p and not p.closed then
    return p
  end
end

return {
  -- noice.nvim 默认把 <C-b> 占用为"向上滚动悬浮文档", 先摘掉它的绑定,
  -- 该功能在下面的 <C-b> 处理函数里保留
  {
    "folke/noice.nvim",
    optional = true,
    keys = function(_, keys)
      return vim.tbl_filter(function(k)
        return (k[1] or ""):lower() ~= "<c-b>"
      end, keys or {})
    end,
  },

  {
    "folke/snacks.nvim",
    keys = {
      -- Ctrl+b 开关文件浏览器 (覆盖 vim 默认的向上翻页)
      {
        "<C-b>",
        function()
          -- 悬浮文档打开时优先滚动它, 保留 noice 原本的行为
          local ok, noice = pcall(require, "noice.lsp")
          if ok and noice.scroll(-4) then
            return
          end
          local p = get_explorer()
          if p then
            p:close()
          else
            Snacks.explorer.open({ cwd = LazyVim.root() })
          end
        end,
        desc = "Toggle Explorer",
      },
      -- <leader>e 进入文件浏览器: 定位到当前文件并把光标移进去
      {
        "<leader>e",
        function()
          Snacks.explorer.reveal()
          -- 浏览器未开时 reveal 是异步打开的, 延后一帧再聚焦
          vim.schedule(function()
            local p = get_explorer()
            if p then
              p:focus("list")
            end
          end)
        end,
        desc = "Focus Explorer",
      },
    },
  },
}
