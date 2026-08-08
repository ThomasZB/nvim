#!/usr/bin/env bash
# 一键安装 Neovim 配置
#   curl -fsSL https://raw.githubusercontent.com/ThomasZB/nvim/main/install.sh | bash
set -euo pipefail

REPO="${NVIM_CONFIG_REPO:-https://github.com/ThomasZB/nvim.git}"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
DATA="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
STATE="${XDG_STATE_HOME:-$HOME/.local/state}/nvim"
CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/nvim"
STAMP="$(date +%Y%m%d%H%M%S)"

red()  { printf '\033[31m%s\033[0m\n' "$*"; }
grn()  { printf '\033[32m%s\033[0m\n' "$*"; }
ylw()  { printf '\033[33m%s\033[0m\n' "$*"; }

# ---------- 1. 检查必需依赖 ----------
missing=()
for c in nvim git; do
  command -v "$c" >/dev/null 2>&1 || missing+=("$c")
done
# C 编译器: treesitter 编译解析器需要
command -v cc >/dev/null 2>&1 || command -v gcc >/dev/null 2>&1 || command -v clang >/dev/null 2>&1 \
  || missing+=("C 编译器 (cc/gcc/clang)")

if [ ${#missing[@]} -gt 0 ]; then
  red "缺少必需依赖: ${missing[*]}"
  echo
  echo "macOS:  brew install neovim git && xcode-select --install"
  echo "Ubuntu: sudo apt install neovim git build-essential"
  exit 1
fi

# nvim 版本需 >= 0.11 (nvim-treesitter main 分支要求)
ver="$(nvim --version | head -1 | sed -E 's/^NVIM v([0-9]+\.[0-9]+).*/\1/')"
major="${ver%%.*}"; minor="${ver##*.}"
if [ "$major" -eq 0 ] && [ "$minor" -lt 11 ]; then
  red "Neovim 版本过低: v$ver (需要 >= 0.11)"
  echo "macOS:  brew upgrade neovim"
  echo "其他:   https://github.com/neovim/neovim/releases"
  exit 1
fi
grn "✓ Neovim v$ver"

# ---------- 2. 可选依赖提示 ----------
optional=()
command -v rg      >/dev/null 2>&1 || optional+=("ripgrep (全文搜索)")
command -v fd      >/dev/null 2>&1 || optional+=("fd (文件搜索提速)")
command -v lazygit >/dev/null 2>&1 || optional+=("lazygit (<leader>gg 图形化 git)")
if [ ${#optional[@]} -gt 0 ]; then
  ylw "可选依赖未安装 (不影响使用):"
  for o in "${optional[@]}"; do echo "    - $o"; done
  echo "    macOS: brew install ripgrep fd lazygit"
fi

# ---------- 3. 备份已有配置 ----------
backed_up=0
for d in "$CONFIG" "$DATA" "$STATE" "$CACHE"; do
  if [ -e "$d" ]; then
    mv "$d" "$d.bak.$STAMP"
    echo "已备份: $d -> $d.bak.$STAMP"
    backed_up=1
  fi
done
if [ "$backed_up" -eq 1 ]; then
  ylw "如需还原: 删除新目录后把 .bak.$STAMP 改回原名"
fi

# ---------- 4. 克隆 ----------
# 保留 .git, 以后可以直接 git pull 同步配置改动
git clone "$REPO" "$CONFIG"
grn "✓ 配置已克隆到 $CONFIG"

# ---------- 5. 装插件 ----------
echo "正在安装插件 (首次需要几分钟)..."
nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
grn "✓ 插件安装完成"

# ---------- 6. 预装语法解析器 ----------
# 不预装的话, 第一次打开 C++ 文件会没有高亮 (要等解析器现编译)
echo "正在编译 treesitter 解析器..."
nvim --headless -c 'lua require("lazy").load({plugins={"nvim-treesitter"}}); require("nvim-treesitter").install({"c","cpp","lua","vim","vimdoc","query","markdown","markdown_inline","bash","python","json","yaml","toml","cmake"}):wait(600000)' -c qa 2>/dev/null || true
grn "✓ 解析器就绪"

# ---------- 7. 预装语言服务器 ----------
echo "正在下载语言服务器..."
nvim --headless -c 'Lazy! load mason.nvim' -c 'MasonInstall clangd lua-language-server' -c qa 2>/dev/null || true
grn "✓ 语言服务器就绪"

echo
grn "全部完成，直接运行 nvim 即可。"
echo "快捷键速查: $CONFIG/KEYMAPS.md"
echo "更新配置:   cd $CONFIG && git pull"
