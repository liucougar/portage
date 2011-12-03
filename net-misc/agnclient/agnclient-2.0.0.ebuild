# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit rpm eutils

SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64"
DESCRIPTION="AT&T Global Network Client"
HOMEPAGE="http://attnetclient.com/forum/viewforum.php?f=10"

MY_PV="agnclient-1.0-2.0.0.3000"
SRC_URI="${MY_PV}.i386.rpm"

RDEPEND="app-emulation/emul-linux-x86-xlibs
         app-emulation/emul-linux-x86-gtklibs
		 app-emulation/emul-linux-x86-compat
		 app-emulation/emul-linux-x86-baselibs
		 sys-libs/glibc
		 dev-lang/tcl
		 "

RESTRICT="fetch"

IUSE="initscript noresolvconf"

S=${WORKDIR}

src_unpack()
{
	rpm_src_unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/agnclient-init.d-v1-gentoo.patch"
	use noresolvconf && epatch "${FILESDIR}/agnclient-noresolvconf-v1.patch"

	rm -rf ${S}/etc/ld.so.conf.d
	rm -rf ${S}/etc/pm

	mv ${S}/etc/rc.d/init.d ${S}/etc/init.d
	rm -rf ${S}/etc/rc.d

	mkdir ${S}/etc/env.d
	echo "LDPATH=\"${ROOT}/opt/agns/lib\"" > ${S}/etc/env.d/99agnclient

	if use initscript ; then
		mkdir ${S}/etc/conf.d
		cp ${FILESDIR}/agnVPN-conf.d-v1	${S}/etc/conf.d/agnVPN
		cp ${FILESDIR}/agnVPN-init.d-v1	${S}/etc/init.d/agnVPN
	fi
}

src_install()
{
	local dirs="opt usr var etc"
	cp -pPR ${dirs} ${D} || die "failed to copy"

	dodir /usr/lib32
	dosym libssl.so /usr/lib32/libssl.so.4
	dosym libcrypto.so /usr/lib32/libcrypto.so.4
	dosym libcurl.so /usr/lib32/libcurl.so.3
}
