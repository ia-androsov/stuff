# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )
inherit distutils-r1 flag-o-matic pypi

DESCRIPTION="Library for analysing atomic resolution images"
HOMEPAGE="https://atomap.org/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}")"
S=${WORKDIR}/${P}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python doc test"

RDEPEND="
	>=dev-python/numpy-1.13[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.4[${PYTHON_USEDEP}]
	dev-python/h5py[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/hyperspy-1.5.2[${PYTHON_USEDEP}]
	>=sci-libs/scikit-image-0.17.1[${PYTHON_USEDEP}]
	sci-libs/scikit-learn[${PYTHON_USEDEP}]
	>=dev-python/ase-3.17.0[${PYTHON_USEDEP}]
	dev-python/numba[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

python_test() {
	epytest
}
