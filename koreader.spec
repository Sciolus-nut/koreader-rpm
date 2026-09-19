%global __brp_mangle_shebangs %{nil}
%global debug_package %{nil}

Name:           koreader
Version:        2026.07.1
Release:        1%{?dist}
Summary:        An ebook reader application (EPUB, PDF, DjVu, CBZ, etc.)

License:        AGPL-3.0
URL:            https://koreader.rocks/
Source0:        https://github.com/koreader/koreader/releases/download/v%{version}/koreader-linux-x86_64-v%{version}.tar.xz

BuildArch:      x86_64
Requires:       glibc >= 2.35

%description
KOReader is a document viewer for E Ink devices and desktop Linux,
supporting EPUB, PDF, DjVu, CBZ and many more formats. This package is
built from the official Linux x86_64 self-contained tarball.

%prep
%setup -q -c -n koreader

%install
mkdir -p %{buildroot}%{_prefix}
cp -a bin lib share %{buildroot}%{_prefix}/
sed -i '/^Icon=/a StartupWMClass=luajit' %{buildroot}%{_datadir}/applications/rocks.koreader.KOReader.desktop

%files
%{_prefix}/bin/koreader
%{_prefix}/lib/koreader/
%{_prefix}/share/applications/rocks.koreader.KOReader.desktop
%{_prefix}/share/icons/hicolor/scalable/apps/rocks.koreader.KOReader.svg
%{_prefix}/share/icons/hicolor/512x512/apps/rocks.koreader.KOReader.png
%{_prefix}/share/icons/hicolor/256x256/apps/rocks.koreader.KOReader.png
%{_prefix}/share/metainfo/rocks.koreader.KOReader.metainfo.xml
%{_prefix}/share/man/man1/koreader.1.gz
%{_prefix}/share/doc/koreader/

%changelog
* Sat Sep 19 2026 chief - 2026.07.1-1
- Initial package from official Linux x86_64 tarball
