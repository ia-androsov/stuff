# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/osl/osl-9999.ebuild,v 1.1 2013/03/04 16:11:23 brothermechanic Exp $

EAPI=5

inherit git-2 cmake-utils

DESCRIPTION="Open Shading Language"
HOMEPAGE="http://code.google.com/p/openshadinglanguage/"
EGIT_REPO_URI="https://github.com/DingTo/OpenShadingLanguage.git"
EGIT_BRANCH="blender-fixes"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test tbb"

DEPEND="
	>=dev-libs/boost-1.52.0
	media-libs/openimageio[-pugixml]
	sys-devel/clang
	sys-devel/bison
	sys-devel/flex
	media-libs/ilmbase
	tbb? ( dev-cpp/tbb )"

RDEPEND=""

CMAKE_USE_DIR="${WORKDIR}/${P}/src"

src_unpack() {
	git-2_src_unpack
}

src_configure() {
	epatch "${FILESDIR}"/gabornoise-306.patch || die "Patch failed"
	$(has_version ">=sys-devel/llvm-3.2") && epatch "${FILESDIR}"/llvm32.patch || die "Patch failed"
	$(has_version ">=sys-devel/llvm-3.3") && epatch "${FILESDIR}"/llvm33.patch || die "Patch failed"
	mycmakeargs=(
		$(cmake-utils_use_use tbb TBB)
		$(cmake-utils_use_build test TESTING)
		)
	cmake-utils_src_configure
}

src_install() {
	if use amd64;then
		dobin dist/linux64/bin/*
		dodoc dist/linux64/doc/*
		insinto /usr/include/
		doins -r dist/linux64/include/*
		dolib dist/linux64/lib/*
		insinto /usr/include/OSL/shaders
		doins -r dist/linux64/shaders/*
		cmake-utils_src_install
	elif use x86;then
		dobin dist/linux/bin/*
		dodoc dist/linux/doc/*
		insinto /usr/include/
		doins -r dist/linux/include/*
		dolib dist/linux/lib/*
		insinto /usr/include/OSL/shaders
		doins -r dist/linux/shaders/*
	fi
}
