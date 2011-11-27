# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils

DESCRIPTION="Python bindings for the low-level FUSE API"
HOMEPAGE="http://python-llfuse.googlecode.com/"
SRC_URI="http://pypi.python.org/packages/source/l/llfuse/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_prepare(){
	distutils_src_prepare
	cd "${S}"
	sed -i -e '/sphinx_cython/d' setup.py || die "failed to remove document"
	sed -i -e "s/'-Werror',/'-Werror','-fno-strict-aliasing',/" setup.py
}
