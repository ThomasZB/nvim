# 快捷键速查

`<leader>` = 空格键。★ = 本配置自定义，其余为 LazyVim 默认。

## 文件与浏览器

| 键 | 作用 |
|---|---|
| `Ctrl+b` | ★ 开关文件浏览器 |
| `空格 e` | ★ 进入浏览器（定位当前文件并聚焦） |
| `空格 f` | ★ 搜索文件 |
| `空格 空格` | 搜索文件（同上，无延迟） |
| `Shift+h` / `Shift+l` | 上一个 / 下一个 buffer |
| `空格 bd` | 关闭当前 buffer |

> `空格 f` 是 LazyVim 的 file 前缀，按下后会等约 300ms；嫌慢用 `空格 空格`。

### 浏览器内的文件操作

光标在浏览器窗口里时按：

| 键 | 作用 |
|---|---|
| `a` | 新建（**名字结尾加 `/` 就是文件夹**） |
| `d` / `r` / `c` / `m` | 删除 / 重命名 / 复制 / 移动 |
| `Tab` | 多选（配合 `m` 批量移动） |

> `a` 会自动创建中间目录，直接写 `core/src/utils/new/` 可一次建多层。
> 新建位置是光标所在的目录。

## 搜索

| 键 | 作用 |
|---|---|
| `gr` | **查找函数/变量的所有引用**（语义级，最准） |
| `空格 sw` | 搜索光标下的词（visual 模式下搜选中内容） |
| `空格 sg` | 全项目搜索，边打边出结果 |
| `空格 /` | 同上（顺手的别名） |
| `空格 sb` | 只搜当前文件 |
| `空格 sS` | 按符号名搜索整个项目 |
| `空格 sR` | 恢复上次搜索结果 |
| `空格 sr` | 全项目搜索替换（文本级） |

> **找函数在哪被调用用 `gr`**，它认 C++ 语义，不会误报注释和同名成员。
> 找宏、字符串、配置项这类 LSP 覆盖不到的用 `空格 sw` / `空格 sg`。
> 批量改名优先用 `空格 cr`（LSP rename），只改真正的引用。

结果窗口内：`Ctrl+n` / `Ctrl+p` 移动，回车跳转，`Ctrl+v` 竖直分屏打开，`Esc` 关闭。

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

## 窗口分屏

| 键 | 作用 |
|---|---|
| `Ctrl+w` `v` / `s` | 竖直 / 水平分屏 |
| `Ctrl+h` / `Ctrl+l` | 左右切换窗口 |
| `Ctrl+w` `x` | **两个窗口对调位置**（最常用） |
| `Ctrl+w` `Shift+L` | 当前窗口甩到最右 |
| `Ctrl+w` `Shift+J` | 甩到最下（左右分屏变上下分屏） |
| `Ctrl+w` `=` | 所有窗口等宽 |
| `Ctrl+方向键` | 调整窗口大小 |
| `空格 wd` | 关闭当前窗口 |

> buffer 是全局的，window 只是视口。切换某个窗口显示的文件不影响其他窗口，
> 但 `空格 bd` 删的是 buffer 本身，所有显示它的窗口都会受影响。

## Markdown

| 键 | 作用 |
|---|---|
| `空格 cp` | 浏览器预览开关（保存即刷新，滚动同步） |

> 终端内本身就会渲染（标题色块、表格画框、代码块背景），不用额外操作。
> 切到其他 buffer 时浏览器预览会自动关闭（插件默认行为）。
> 想让它常驻，把 markdown 文件用 `Ctrl+w` `v` 分屏常驻即可。

## 界面开关（`空格 u` 系列）

| 键 | 作用 |
|---|---|
| `空格 uh` | 内嵌提示（函数参数名）**默认关闭** |
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
| `lua/plugins/lsp.lua` | 内嵌提示默认关闭 |
| `lua/config/autocmds.lua` | C++ 语义高亮增强 |

**clangd 诊断太吵**：项目根目录建 `.clangd` 可屏蔽指定路径，例如缺失依赖的适配层：

```yaml
If:
  PathMatch: .*adapters/ros2/.*
Diagnostics:
  Suppress: '*'
```

**遇到莫名其妙的报错**（比如 `'Eigen::Affine2d' (aka 'int')`）先按 `:LspRestart`。这类
`aka 'int'` 是 clang 解析失败后的兜底表现，真正的错误在更靠前的 include。反复出现就清
索引缓存：`rm -rf <项目>/.cache/clangd`。
