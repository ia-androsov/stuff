# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
_PYTHON_ALLOW_PY27=1
PYTHON_COMPAT=( python2_7 )

inherit xdg-utils gnome2-utils python-r1_py2

DESCRIPTION="Framework for Scanning Mode Microscopy data analysis"
HOMEPAGE="http://gwyddion.net/"
SRC_URI="http://gwyddion.net/download/${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE="doc fits fftw gnome nls opengl perl python ruby sourceview xml X"

DEPEND="
	sci-libs/fftw
"

RDEPEND="
	media-libs/libpng:0=
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/libXmu
	x11-libs/pango
	fits? ( sci-libs/cfitsio )
	fftw? ( sci-libs/fftw:3.0= )
	gnome? ( gnome-base/gconf:2 )
	opengl? ( virtual/opengl x11-libs/gtkglext )
	perl? ( dev-lang/perl:= )
	python? ( dev-lang/python:2.7
		dev-python/pygtk:2[${PYTHON_USEDEP}]
	)
	ruby? ( dev-ruby/narray )
	sourceview? ( x11-libs/gtksourceview:2.0 )
	xml? ( dev-libs/libxml2:2 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	econf \
		--disable-rpath \
		--without-kde4-thumbnailer \
		$(use_enable doc gtk-doc) \
		$(use_enable nls) \
		$(use_enable python pygwy) \
		$(use_enable fits cfitsio) \
		$(use_with perl) \
		$(use_with python) \
		$(use_with ruby) \
		$(use_with fftw fftw3) \
		$(use_with opengl gl) \
		$(use_with sourceview gtksourceview) \
		$(use_with xml libxml2) \
		$(use_with X x)
}

src_install() {
	default
	use python && dodoc modules/pygwy/README.pygwy
}

pkg_postinst() {
	use gnome && gnome2_gconf_install
	xdg_pkg_postinst
}

pkg_prerm() {
	use gnome && gnome2_gconf_uninstall
}
