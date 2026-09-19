# KOReader rpm 打包维护说明

KOReader 官方没有 rpm 包，这个 rpm 是用官方 Linux x86_64 自包含 tarball 封装的。
以后 KOReader 出新版本，按下面步骤更新打包即可。

## 文件位置

- spec 文件：~/rpmbuild/SPECS/koreader.spec
- 源码 tarball：~/rpmbuild/SOURCES/koreader-linux-x86_64-v<版本>.tar.xz
- 产出 rpm：~/rpmbuild/RPMS/x86_64/koreader-<版本>-1.fc<版本>.x86_64.rpm

## 更新到新版本的步骤

1. 查最新版本号（GitHub Releases）：
   https://github.com/koreader/koreader/releases
   比如最新 tag 是 v2026.08，则版本号 = 2026.08

2. 改 spec 的 Version 字段（用编辑器或命令）：
   把 ~/rpmbuild/SPECS/koreader.spec 里的 `Version: 2026.07.1` 改成 `Version: 2026.08`

3. 下载新版本 tarball 到 SOURCES（文件名要和 spec 的 Source0 一致）：
   cd ~/rpmbuild/SOURCES
   curl -L -o koreader-linux-x86_64-v2026.08.tar.xz \
     https://github.com/koreader/koreader/releases/download/v2026.08/koreader-linux-x86_64-v2026.08.tar.xz

4. 打包：
   cd ~/rpmbuild
   rpmbuild -bb SPECS/koreader.spec

5. 安装 / 升级：
   sudo dnf upgrade ./RPMS/x86_64/koreader-2026.08-1.fc*.x86_64.rpm

## spec 里的两个关键宏（不要删，删了会报错）

- `%global __brp_mangle_shebangs %{nil}`
  KOReader 的 reader.lua 用相对路径 shebang（./luajit），rpm 的 shebang 检查会报错，必须禁用。

- `%global debug_package %{nil}`
  KOReader 是预编译第三方二进制，没有 build-id，find-debuginfo 严格模式会失败，必须禁用。

## 注意事项

- 版本号：GitHub tag 是 v2026.07.1（带 v），spec 的 Version 要去掉 v，写 2026.07.1
- Source0 文件名格式：koreader-linux-x86_64-v<版本>.tar.xz（注意中间的 v）
- 打包后 rpm 在 RPMS/x86_64/ 目录下
- 安装后占用约 91 MB（解压状态），比 AppImage（39 MB）大，但能用 dnf 统一管理、卸载干净
