# Neovim 配置

基于 [LazyVim](https://github.com/LazyVim/LazyVim)，针对 C/C++ 开发调整。

📖 **[快捷键速查 → KEYMAPS.md](KEYMAPS.md)**

## 新电脑一键安装

```bash
curl -fsSL https://raw.githubusercontent.com/ThomasZB/nvim/main/install.sh | bash
```

脚本会检查依赖 → 备份已有配置 → 克隆本仓库 → 装插件 → 预编译语法解析器 → 下载语言服务器。全程约 3-5 分钟，结束后直接 `nvim` 即可使用。

> 不放心直接管道执行的话，分两步走：
> ```bash
> curl -fsSL -o install.sh https://raw.githubusercontent.com/ThomasZB/nvim/main/install.sh
> less install.sh && bash install.sh
> ```

**已有配置会被备份**，不会丢失。脚本把 `~/.config/nvim`、`~/.local/share/nvim`、`~/.local/state/nvim`、`~/.cache/nvim` 改名为 `xxx.bak.<时间戳>` 保留，只移动不删除。想还原就删掉新目录、把 `.bak` 后缀去掉。

### 手动安装

```bash
git clone https://github.com/ThomasZB/nvim.git ~/.config/nvim
nvim
```

插件会自动安装；语法解析器和语言服务器在首次打开对应语言文件时下载，等一两分钟即可。

## 依赖

**必需**

| 依赖 | 说明 |
|---|---|
| Neovim >= 0.11 | 低于此版本 nvim-treesitter 无法工作 |
| git | |
| C 编译器 | 编译 treesitter 解析器 |

```bash
# macOS
brew install neovim git && xcode-select --install
# Ubuntu
sudo apt install neovim git build-essential
```

**可选**（缺了不影响基本使用）

```bash
brew install ripgrep fd lazygit    # 全文搜索 / 文件搜索提速 / 图形化 git
```

终端字体建议装 [Nerd Font](https://www.nerdfonts.com/)，否则图标显示为方块。

## 配置了什么

**C/C++**
- clangd：跳转、补全、重命名、诊断
- `Option+o` 在 `.h` / `.cc` 间切换
- 语义高亮增强：类/结构体/枚举加粗，函数参数斜体，与局部变量区分
- 保存时按 `.clang-format` 自动格式化

**编辑**
- `jj` 退出 insert 模式
- `Tab` 接受补全（而非回车）
- `Ctrl+b` 开关文件浏览器，`空格 e` 进入浏览器

**其他**
- 裸启动 `nvim` 自动恢复上次打开的文件
- markdown：`空格 cp` 浏览器预览，终端内也直接渲染
- 配色 gruvbox-material，另装 catppuccin / kanagawa / vscode / nightfox，`空格 uC` 实时切换

## 日常维护

```bash
# 改了配置后同步
cd ~/.config/nvim && git add -A && git commit -m "..." && git push

# 其他电脑拉取
cd ~/.config/nvim && git pull
```

`lazy-lock.json` 锁定了所有插件的具体版本，保证各台机器环境一致。用 `:Lazy update` 更新插件后，记得把它一起提交。

## C/C++ 项目跳转失效？

clangd 需要知道编译参数。项目根目录放以下任一文件即可：

```bash
# CMake 项目
cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && ln -s build/compile_commands.json .
```

或手写 `compile_flags.txt`（纯文本，一行一个参数，不需要编译环境）：

```
-xc++
-std=c++17
-I./include
-I./src
```

用 `:LspInfo` 可查看 clangd 当前状态。
