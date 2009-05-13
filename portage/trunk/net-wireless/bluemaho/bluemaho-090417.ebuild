# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-wireless/btscanner/btscanner-2.1.ebuild,v 1.1.1.1 2006/03/09 22:54:57 grimmlin Exp $
EAPI=2
inherit eutils

MY_P="${PN}_v${PV}"

DESCRIPTION="BlueMaho is GUI-shell (interface) for suite of tools for testing security of bluetooth devices"
HOMEPAGE="http://wiki.thc.org/BlueMaho"
SRC_URI="http://wiki.thc.org/BlueMaho?action=AttachFile&do=get&target=${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RDEPEND="net-wireless/bluez-utils[test-programs]
	 net-wireless/bluez-libs
	 net-wireless/bt-audit
	 dev-libs/libxml2
	 dev-python/wxpython
	 dev-libs/libusb
	 sys-libs/readline"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P/_v/-}"

src_compile() {
	epatch "${FILESDIR}/btftp-libxml.patch"
	cd ${S}
	sed -e 's/Eterm/xterm/'	-i config/default.conf
	cd config
	sh build.sh || die "emake failed"
}

src_install() {
	dodir /usr/lib/${PN}
	cp -R "${S}"/* "${D}"/usr/lib/${PN} || die "Copy files failed"
	dobin "${FILESDIR}/${PN}"
}
