#!/usr/bin/env bash
# build-koreader.sh — 一键打包 KOReader rpm
# 用法：
#   ./build-koreader.sh            # 自动查最新版本并打包
#   ./build-koreader.sh 2026.08    # 打包指定版本（可带 v 前缀，如 v2026.08）
set -euo pipefail

SPEC="$HOME/rpmbuild/SPECS/koreader.spec"
SOURCES="$HOME/rpmbuild/SOURCES"
RPMS="$HOME/rpmbuild/RPMS/x86_64"
REPO="koreader/koreader"

# 1. 确定版本号
if [[ -n "${1:-}" ]]; then
    VERSION="${1#v}"   # 去掉可能的 v 前缀
else
    echo "查询 KOReader 最新版本…"
    VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" \
        | grep -oP '"tag_name":\s*"\K[^"]+' | sed 's/^v//')
fi
echo "目标版本: $VERSION"

# 2. 下载 tarball（本地没有才下）
TARBALL="$SOURCES/koreader-linux-x86_64-v$VERSION.tar.xz"
if [[ ! -f "$TARBALL" ]]; then
    echo "下载 tarball…"
    curl -fL -o "$TARBALL" \
        "https://github.com/$REPO/releases/download/v$VERSION/koreader-linux-x86_64-v$VERSION.tar.xz"
else
    echo "tarball 已存在，跳过下载"
fi

# 3. 更新 spec 的 Version 字段
echo "更新 spec 版本号…"
sed -i "s/^Version:.*/Version:        $VERSION/" "$SPEC"
grep -E "^Version:" "$SPEC"

# 4. 打包
echo "开始打包…"
cd "$HOME/rpmbuild"
rpmbuild -bb SPECS/koreader.spec

# 5. 报告产物
echo
echo "=== 打包完成 ==="
ls -lh "$RPMS"/koreader-$VERSION-1*.rpm
