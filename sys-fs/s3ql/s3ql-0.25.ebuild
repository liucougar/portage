# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="a full-featured file system for online data storage"
HOMEPAGE="http://code.google.com/p/s3ql/"
SRC_URI="http://s3ql.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="contrib"

DEPEND="dev-python/setuptools
	dev-cpp/gccxml"
RDEPEND="sys-fs/fuse
	dev-python/argparse
	dev-python/pycryptopp
	>=dev-python/apsw-3.7.0
	test? ( net-misc/rsync[xattr]
		dev-python/unittest2
		)
	dev-python/paramiko
	dev-python/pyliblzma"

function src_install(){
	distutils_src_install

	if use contrib ; then
		insinto /usr/share/doc/${PF}
		doins -r contrib || die 'Failed to install contrib modules'
	fi
}

function src_test(){
	if hasq userpriv ${FEATURES} ; then
		eerror "These tests need root privileges. Disable userpriv!"
		die "userpriv is not supported"
	fi
	# /dev/fuse is used by the test
	addwrite /dev/fuse
	distutils_src_test
}
