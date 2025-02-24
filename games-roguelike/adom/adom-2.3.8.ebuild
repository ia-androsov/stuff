# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit edos2unix

DESCRIPTION="Ancient Domains Of Mystery rogue-like game"
HOMEPAGE="http://www.adom.de/"
SRC_URI="
x86? ( https://www.adom.de/home/download/old/${PV}/${PN}_linux_debian_32_${PV}.tar.gz )
amd64? ( https://www.adom.de/home/download/old/${PV}/${PN}_linux_debian_64_${PV}.tar.gz )
arm? ( https://www.adom.de/home/download/old/${PV}/${PN}_linux_arm_${PV}.tar.gz )"

LICENSE="adom"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
RESTRICT="strip" #bug #137340
QA_FLAGS_IGNORED="/opt/bin/adom"

DEPEND="!arm? ( >=sys-libs/ncurses-5.0[tinfo] )"

S=${WORKDIR}/${PN}

src_install() {
	exeinto /opt/bin
	doexe adom

	insinto /etc
	echo "${EPREFIX}"/var/lib/${PN} > adom_ds.cfg || die
	doins adom_ds.cfg

	edos2unix docs/{adomfaq.txt,manual.txt,readme1st.txt}
	dodoc docs/{adomfaq.txt,manual.txt,readme1st.txt}

	keepdir /var/lib/${PN}
	fperms g+w /var/lib/${PN}
}
