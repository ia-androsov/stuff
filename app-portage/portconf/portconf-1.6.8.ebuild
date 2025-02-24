# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="/etc/portage cleaner"
HOMEPAGE="https://github.com/megabaks/portconf"
SRC_URI="https://github.com/megabaks/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
RESTRICT="mirror"

DEPEND="app-shells/bash:=
		sys-apps/portage"
RDEPEND="${DEPEND}
		app-portage/eix
		app-portage/portage-utils
		sys-apps/gawk
		app-text/agrep"

src_install(){
	insinto /etc/
	newins portconf.conf portconf.conf
	dosbin portconf
}
