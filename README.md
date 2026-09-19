# KOReader rpm packaging

KOReader doesn't provide an official rpm package. This repo repackages it into a Fedora rpm from the official Linux x86_64 self-contained tarball — no code changes, just packaging.

## Upstream

- [KOReader](https://github.com/koreader/koreader) — the original ebook reader project (AGPL-3.0)
- This repo only repackages the official release binaries; all credit goes to the KOReader team.

## Files

- `koreader.spec` — rpm spec file
- `build-koreader.sh` — one-shot build script
- `BUILDING.md` — maintenance guide (update steps + known pitfalls)

## Quick build

```bash
# Auto-detect latest version and build
./build-koreader.sh

# Or pin a version (optional v prefix)
./build-koreader.sh 2026.07.1
```

Output lands in `~/rpmbuild/RPMS/x86_64/`.

## Install

```bash
sudo dnf install ./koreader-<version>-1.fc*.x86_64.rpm
```

Pre-built rpms are also published on the [Releases page](https://github.com/Sciolus-nut/koreader-rpm/releases).

## Prerequisites

- Fedora
- `rpm-build` (`sudo dnf install rpm-build`)

## Notes

- reader.lua uses a relative-path shebang (`./luajit`), so the spec disables shebang mangling
- Prebuilt binaries lack build-id, so the spec disables debuginfo generation
- See `BUILDING.md` for details

## Other languages

- 简体中文：[README.zh-CN.md](README.zh-CN.md)
