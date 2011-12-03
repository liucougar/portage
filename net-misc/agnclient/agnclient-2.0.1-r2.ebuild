# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit rpm eutils

SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64"
DESCRIPTION="AT&T Global Network Client"
HOMEPAGE="ftp://ftp.attglobal.net/pub/custom/ibm_linux/"

MY_PV="agnclient-1.0-2.0.1.3003"
SRC_URI="ftp://ftp.attglobal.net/pub/custom/ibm_linux/${MY_PV}.i386.rpm"

RDEPEND="X? (
			app-emulation/emul-linux-x86-xlibs 
         	app-emulation/emul-linux-x86-gtklibs
		 )
		 app-emulation/emul-linux-x86-compat
		 app-emulation/emul-linux-x86-baselibs
		 sys-libs/glibc
		 dev-lang/tcl
		 "

#RESTRICT="fetch"

IUSE="initscript noresolvconf X"

S=${WORKDIR}

src_unpack()
{
	cd "${S}"

	rpm_src_unpack ${A}

	#epatch "${FILESDIR}/agnclient-init.d-v1-gentoo.patch"
	use noresolvconf && epatch "${FILESDIR}/agnclient-noresolvconf-v2.patch"

	rm -rf ${S}/etc/{ld.so.conf.d,pm,rc.d}

	echo "LDPATH=\"${ROOT}/opt/agns/lib\"" > ${S}/99agnclient
}

src_install()
{
	local dirs="opt usr var etc"
	cp -pPR ${dirs} ${D} || die "failed to copy"

	newenvd "${S}/99agnclient" 99agnclient

	newinitd "${FILESDIR}"/agnclientd-init.d agnclientd
	newinitd "${FILESDIR}"/agnLogd-init.d agnLogd

	if use initscript ; then
		newconfd "${FILESDIR}/agnVPN-conf.d-v1" agnVPN
		newinitd "${FILESDIR}/agnVPN-init.d-v1" agnVPN
	fi

	dodir /usr/lib32
	dosym libssl.so /usr/lib32/libssl.so.4
	dosym libcrypto.so /usr/lib32/libcrypto.so.4
	dosym libcurl.so /usr/lib32/libcurl.so.3
}
