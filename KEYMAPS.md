# 快捷键速查

`<leader>` = 空格键。★ = 本配置自定义，其余为 LazyVim 默认。

## 文件与浏览器

| 键 | 作用 |
|---|---|
| `Ctrl+b` | ★ 开关文件浏览器 |
| `空格 e` | ★ 进入浏览器（定位当前文件并聚焦） |
| `空格 f` | ★ 搜索文件 |
| `空格 空格` | 搜索文件（同上，无延迟） |
| `空格 /` | 全项目搜索内容 |
| `Shift+h` / `Shift+l` | 上一个 / 下一个 buffer |
| `空格 bd` | 关闭当前 buffer |

> `空格 f` 是 LazyVim 的 file 前缀，按下后会等约 300ms；嫌慢用 `空格 空格`。

## 代码跳转

| 键 | 作用 |
|---|---|
| `gd` | 跳转到定义 |
| `gr` | 查找引用 |
| `gI` | 跳转到实现 |
| `gy` | 跳转到类型定义 |
| `K` | 悬浮文档 |
| `Ctrl+o` / `Ctrl+i` | 后退 / 前进 |
| `空格 ss` | 当前文件符号列表 |
| `空格 ca` | 代码操作（Code Action） |
| `空格 cr` | 重命名符号 |

## C/C++ 专用

| 键 | 作用 |
|---|---|
| `Option+o` | ★ `.h` ↔ `.cc` 切换 |
| `空格 ch` | 同上（终端不支持 Option 时用） |
| `空格 cf` | 格式化（走 `.clang-format`） |

> 保存时会自动格式化，`空格 uf` 可关闭该行为。
> 跨文件跳转依赖项目根目录的 `compile_commands.json` 或 `compile_flags.txt`。

## 编辑与补全

| 键 | 作用 |
|---|---|
| `jj` | ★ 退出 insert 模式 |
| `Tab` | ★ 接受补全 / 跳转 snippet 占位符 |
| `Ctrl+n` / `Ctrl+p` | 补全项上下移动 |
| `Ctrl+e` | 关闭补全菜单 |
| `gcc` / `gc`（选中后） | 注释行 / 注释选区 |

## 界面开关（`空格 u` 系列）

| 键 | 作用 |
|---|---|
| `空格 uh` | 内嵌提示（函数参数名） |
| `空格 uf` | 保存时自动格式化 |
| `空格 ud` | 诊断信息（报错波浪线） |
| `空格 uw` | 自动换行 |
| `空格 ul` | 行号 |
| `空格 uC` | 配色方案选择器（实时预览） |

> 按 `空格 u` 停顿一下会弹出完整菜单。

## 会话

裸启动 `nvim` 时自动恢复上次打开的文件（带文件名启动则不恢复）。

| 键 | 作用 |
|---|---|
| `空格 qs` | 手动恢复当前目录会话 |
| `空格 ql` | 恢复最近一次会话 |
| `空格 qd` | 本次退出不保存会话 |

## 已装配色

`空格 uC` 里可实时预览切换，固定用哪个改 `lua/plugins/colorscheme.lua`。

- **gruvbox-material**（当前）
- catppuccin：`-latte` `-frappe` `-macchiato` `-mocha`
- kanagawa：`-wave` `-dragon` `-lotus`
- vscode（VSCode Dark+ 复刻）
- nightfox：`carbonfox` `duskfox` `nordfox` `terafox` `dawnfox` `dayfox`
- tokyonight：`-day` `-storm` `-moon` `-night`

## 备注

**Option+o 需要终端支持**。iTerm2：Settings → Profiles → Keys → Left Option Key 选 `Esc+`（建议只改左边，右 Option 保留 `Normal` 以便输入特殊字符）。Kitty / WezTerm / Ghostty 默认可用。

**自定义配置位置**

| 文件 | 内容 |
|---|---|
| `lua/config/keymaps.lua` | `空格 f`、`jj` |
| `lua/plugins/explorer.lua` | `Ctrl+b`、`空格 e` |
| `lua/plugins/cpp.lua` | `Option+o` |
| `lua/plugins/blink.lua` | Tab 补全 |
| `lua/plugins/persistence.lua` | 会话自动恢复 |
| `lua/plugins/colorscheme.lua` | 配色 |
| `lua/config/autocmds.lua` | C++ 语义高亮增强 |
