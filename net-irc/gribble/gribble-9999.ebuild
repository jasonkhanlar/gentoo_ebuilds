# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/supybot/supybot-0.83.4.1-r1.ebuild,v 1.6 2010/04/04 21:01:51 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

EGIT_REPO_URI="git://gribble.git.sourceforge.net/gitroot/gribble/gribble"
EGIT_PROJECT="gribble/gribble"

inherit distutils eutils git python

DESCRIPTION="Python based extensible IRC infobot and channel bot"
HOMEPAGE="http://gribble.sf.net/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sqlite twisted"

DEPEND="sqlite? ( <dev-python/pysqlite-1.1 )
	twisted? (
		>=dev-python/twisted-8.1.0[crypt]
		>=dev-python/twisted-names-8.1.0
	)"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="ACKS RELNOTES docs/*"

src_unpack() {
	git_src_unpack
}

src_install() {
	distutils_src_install
	doman docs/man/*
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "Use supybot-wizard to create a configuration file"
	use sqlite || \
		elog "Some plugins may require emerge with USE=\"sqlite\" to work."
	use twisted && \
		elog "If you want to use Twisted as your supybot.driver, add it to your"
		elog "config file: supybot.drivers.module = Twisted."
		elog "You will need this for SSL connections"
	use twisted || \
		elog "To allow supybot to use Twisted as driver, re-emerge with"
		elog "USE=\"twisted\" flag. You will need this for SSL Connections"
}