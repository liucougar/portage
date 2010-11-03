# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.1

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils


DESCRIPTION="Python bindings for liblzma"
HOMEPAGE="https://launchpad.net/pyliblzma"
SRC_URI="http://pypi.python.org/packages/source/p/pyliblzma/${P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="app-arch/xz-utils"
RESTRICT_PYTHON_ABIS="3.*"
