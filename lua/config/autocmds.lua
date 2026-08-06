-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 强化 C++ 语义高亮的区分度
-- clangd 的语义 token (@lsp.type.*) 优先级高于 treesitter, C++ 代码里
-- 实际生效的是这些组; 配色方案的 styles 选项通常管不到它们, 所以这里直接改
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("cpp_semantic_styles", { clear = true }),
  callback = function()
    -- 注意: nvim_set_hl 是整组替换, 必须先读出原有属性再叠加, 否则会丢失颜色
    local function add_style(group, style)
      local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
      if vim.tbl_isempty(hl) then
        return
      end
      hl = vim.tbl_extend("force", hl, style)
      vim.api.nvim_set_hl(0, group, hl)
    end

    for _, ft in ipairs({ "cpp", "c" }) do
      -- 类型加粗
      for _, t in ipairs({ "class", "struct", "enum", "typeParameter" }) do
        add_style("@lsp.type." .. t .. "." .. ft, { bold = true })
      end
      -- 函数参数斜体, 便于和局部变量区分
      add_style("@lsp.type.parameter." .. ft, { italic = true })
    end
  end,
})
