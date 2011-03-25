# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit rpm

DESCRIPTION="Lexmark inkjet printer driver (supported printers lxPro200-S500,
lxPro700, lxPro800-Pro900, lxS300-S400, lxS600, lxX2600, lxX3646, lxX4900,
lxX5666, lxX7600, lxZ2300, lxZ2400)"
HOMEPAGE="http://support.lexmark.com/index?segment=SUPPORT&userlocale=EN_US&locale=en&productCode=LEXMARK_PINNACLE_PRO901&page=product&frompage=null#1"
SRC_URI="http://downloads.lexmark.com/downloads/cpd/lexmark-inkjet-legacy-1.0-1.x86_64.rpm.sh.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	net-print/cups"

function src_unpack(){
	#unpack the tar.gz to extrac the sh file
	default

	#extract the content of the install script
	bash *.sh --tar xf || die "Failed to extract rpm from shell script"

	#instarchive_all is actually a tar.lzma file, give it properly suffix so
	#unpack can handle it
	mv instarchive_all instarchive_all.tar.lzma || die "Failed to rename arhive file"
	unpack ./instarchive_all.tar.lzma

	#finally, we have our rpm, unpack it
	rpm_unpack ./lexmark-inkjet-*.rpm
}

function src_compile(){
	filterpath=$(cups-config --serverbin)/filter
	wrongpath="/usr/local/lexmark/legacy/bin"
	sedcmd="s,${wrongpath},${filterpath},"
	for i in usr/local/lexmark/legacy/etc/*.ppd ; do
		sed -i -e "$sedcmd" "$i"
	done
}

function src_install(){
	insinto $(cups-config --serverbin)/backend
	doins usr/local/lexmark/legacy/bin/lxhcp

	insinto /usr/share/ppd/Lexmark/
	doins usr/local/lexmark/legacy/etc/*.ppd

	filterpath=$(cups-config --serverbin)/filter
	exeinto $filterpath
	doexe usr/local/lexmark/legacy/bin/printfilter
}
