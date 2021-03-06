TERMUX_PKG_HOMEPAGE=https://en.wikipedia.org/wiki/Util-linux
TERMUX_PKG_DESCRIPTION="Miscellaneous system utilities"
TERMUX_PKG_VERSION=2.29.2
TERMUX_PKG_SRCURL=https://www.kernel.org/pub/linux/utils/util-linux/v2.29/util-linux-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=accea4d678209f97f634f40a93b7e9fcad5915d1f4749f6c47bee6bf110fe8e3
TERMUX_PKG_DEPENDS="ncurses, libutil"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_setns=yes
ac_cv_func_unshare=yes
--disable-agetty
--disable-eject
--disable-ipcrm
--disable-ipcs
--disable-kill
--disable-last
--disable-libuuid
--disable-logger
--disable-pivot_root
--disable-switch_root
--disable-wall
--disable-libmount
"
# bin/column is currently bundled in the fish package:
TERMUX_PKG_RM_AFTER_INSTALL="bin/column share/man/man1/column.1"

termux_step_pre_configure() {
	if [ $TERMUX_ARCH_BITS = 64 ]; then
		# prlimit() is only available in 64-bit bionic.
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_prlimit=yes"
	fi
}
