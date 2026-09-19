# KOReader rpm 打包

KOReader 官方不提供 rpm 包，本仓库用官方 Linux x86_64 自包含 tarball 封装成 Fedora 可用的 rpm。

## 文件

- `koreader.spec` — rpm 打包规格文件
- `build-koreader.sh` — 一键打包脚本
- `BUILDING.md` — 维护说明（更新版本的完整步骤 + 踩坑记录）

## 快速打包

```bash
# 自动查最新版本并打包
./build-koreader.sh

# 或指定版本（v 前缀可带可不带）
./build-koreader.sh 2026.07.1
```

产物输出到 `~/rpmbuild/RPMS/x86_64/`。

## 安装

```bash
sudo dnf install ./koreader-<版本>-1.fc*.x86_64.rpm
```

## 前置依赖

- Fedora 系统
- `rpm-build` 包（`sudo dnf install rpm-build`）

## 说明

- 官方 tarball 里 reader.lua 用相对路径 shebang（`./luajit`），spec 里已禁用 shebang 检查处理
- 预编译二进制无 build-id，spec 里已禁用 debuginfo 生成
- 详见 `BUILDING.md`
