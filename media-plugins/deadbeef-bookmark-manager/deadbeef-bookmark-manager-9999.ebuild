# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Bookmark Manager plugin for DeaDBeeF audio player"
HOMEPAGE="https://github.com/cboxdoerfer/ddb_bookmark_manager"
EGIT_REPO_URI="https://github.com/cboxdoerfer/ddb_bookmark_manager.git"

LICENSE="GPL-2"
SLOT="0"

DEPEND_COMMON="media-sound/deadbeef"

RDEPEND="${DEPEND_COMMON}"
DEPEND="${DEPEND_COMMON}"

src_install() {
	insinto /usr/$(get_libdir)/deadbeef
	doins ddb_misc_bookmark_manager.so
}
