From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 7237] New: desktop doesn't want to standby
Date: Sat, 30 Sep 2006 13:01:31 -0700
Message-ID: <20060930130131.eb30afb9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:64746 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751864AbWI3UBj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Sep 2006 16:01:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8UK1WaX010209
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sat, 30 Sep 2006 13:01:32 -0700
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k8UK1VC9030309
	for <linux-acpi@vger.kernel.org>; Sat, 30 Sep 2006 13:01:31 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


I suspect this one is miscategorised.

Begin forwarded message:

Date: Sat, 30 Sep 2006 09:32:03 -0700
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 7237] New: desktop doesn't want to standby


http://bugzilla.kernel.org/show_bug.cgi?id=7237

           Summary: desktop doesn't want to standby
    Kernel Version: 2.6.18 vanilla from kernel.org without patches or
                    external modul
            Status: NEW
          Severity: normal
             Owner: power-management_other@kernel-bugs.osdl.org
         Submitter: mailinux@no-log.org


Most recent kernel where this bug did not occur:
Distribution:gentoo
Hardware Environment:sempron 2500+,256 ram,
# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge
(rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:09.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
00:09.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
00:0a.0 Ethernet controller: D-Link System Inc Unknown device 4b01 (rev 11)
00:0b.0 Network controller: RaLink RT2500 802.11g Cardbus/mini-PCI (rev 01)
00:0d.0 SCSI storage controller: Initio Corporation 360P (rev 02)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
(rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
(rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
(rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
(rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237
AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE]
(rev 01)
01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE]
(Secondary) (rev 01)
Software Environment:
# emerge --info
Portage 2.1.1 (default-linux/x86/2006.1, gcc-4.1.1, glibc-2.4-r3,
2.6.18-gentoo_sempron_2500 i686)
=================================================================
System uname: 2.6.18-gentoo_sempron_2500 i686 AMD Sempron(tm) 2500+
Gentoo Base System version 1.6.13
Last Sync: Fri, 29 Sep 2006 19:00:01 +0000
app-admin/eselect-compiler: [Not Present]
dev-java/java-config: 1.2.11-r1
dev-lang/python:     2.3.5-r2
dev-python/pycrypto: 2.0.1-r5
dev-util/ccache:     [Not Present]
dev-util/confcache:  [Not Present]
sys-apps/sandbox:    1.2.17
sys-devel/autoconf:  2.13, 2.59-r6
sys-devel/automake:  1.4_p6, 1.5, 1.6.3, 1.7.9-r1, 1.8.5-r3, 1.9.6-r1
sys-devel/binutils:  2.16.1-r3
sys-devel/gcc-config: 1.3.13-r2
sys-devel/libtool:   1.5.18-r1
virtual/os-headers:  2.6.11-r2
ACCEPT_KEYWORDS="x86"
AUTOCLEAN="yes"
CBUILD="i686-pc-linux-gnu"
CFLAGS="-O2 -march=athlon-xp -pipe"
CHOST="i686-pc-linux-gnu"
CONFIG_PROTECT="/etc /usr/kde/3.4/env /usr/kde/3.4/share/config
/usr/kde/3.4/shutdown /usr/kde/3.5/env /usr/kde/3.5/share/config
/usr/kde/3.5/shutdown /usr/share/X11/xkb /usr/share/config"
CONFIG_PROTECT_MASK="/etc/env.d /etc/gconf /etc/revdep-rebuild /etc/terminfo"
CXXFLAGS="-O2 -march=athlon-xp -pipe"
DISTDIR="/usr/portage/distfiles"
FEATURES="autoconfig distlocks metadata-transfer sandbox sfperms strict"
GENTOO_MIRRORS="http://distfiles.gentoo.org
http://distro.ibiblio.org/pub/linux/distributions/gentoo"
LINGUAS=""
PKGDIR="/usr/portage/packages"
PORTAGE_RSYNC_OPTS="--recursive --links --safe-links --perms --times --compress
--force --whole-file --delete --delete-after --stats --timeout=180
--exclude='/distfiles' --exclude='/local' --exclude='/packages'"
PORTAGE_TMPDIR="/var/tmp"
PORTDIR="/usr/portage"
PORTDIR_OVERLAY="/usr/overlay"
SYNC="rsync://rsync.gentoo.org/gentoo-portage"
USE="x86 3dnow 7zip X a52 aac acl ada alsa audacious avahi berkdb bitmap-fonts
cddb cli crypt css cups dedicated dlloader dri dv dvd dvdread elibc_glibc encode
fame fat ffmpeg flac fortran gcj gdbm gif gimp gimpprint gimpprint-mng gphoto2
gpm graphviz gs gtk haskell hfs imagemagick input_devices_evdev
input_devices_keyboard input_devices_mouse isdnlog jfs jpeg jpeg2k kde kerberos
kernel_linux lcms libfpx libg++ lzo matroska mjpeg mmx mng modplug mp3 mpeg
musepack musicbrainz ncurses network nls nodrm nptl nptlonly ntfs ogg
on-the-fly-crypt opengl pam pascal pcre perl php png ppds pppd python qt3 quotas
readline reflection reiser4 reiserfs rle ruby samba sdl session skins sndfile
speex spl sql sse ssl stream svg swat tcpd theora tiff timidity truetype
truetype-fonts type1-fonts udev unicode usb userland_GNU v4l vcd
video_cards_radeon vlm vorbis wma wmf wxwindows xfs xorg xvid yv12 zeroconf zlib"
Unset:  CTARGET, EMERGE_DEFAULT_OPTS, INSTALL_MASK, LANG, LC_ALL, LDFLAGS,
MAKEOPTS, PORTAGE_RSYNC_EXTRA_OPTS

Problem Description:
1st try:the computer doesn't want to standby
2nd try:the computer freeze

Steps to reproduce:
echo standby>/sys/power/state

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
