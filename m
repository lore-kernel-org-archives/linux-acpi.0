From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: Re: S3 broken Samsung P35 - howto debug?
Date: Wed, 24 Nov 2004 14:13:47 +0100
Message-ID: <1101302028.7910.14.camel@mhcln03>
References: <200411211600.01820.od@fet.uni-hannover.de>
	 <1101064133.7220.15.camel@mhcln03>  <41A4613F.2020905@helios.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-GJc3uf76Xb1V+84vGpXr"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41A4613F.2020905-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-GJc3uf76Xb1V+84vGpXr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Mittwoch, den 24.11.2004, 11:23 +0100 schrieb Oliver Dawid:
> Hi,
> 
> now machine is resuming (unfortunately without display waking up) - so I 
> got a little success but there is still work to be done.
> 
> Matthias Hentges wrote:

[...]

> > I've managed to get the backlight on, but that's it heh.
> 
> Now its time to switch on my backlight ;-)

It won't be of much use. For some reason the Radeon doesn't come back
after S3.
Trying video_post or boot_radeon or s3_late_bios will freeze the
machine.
Basically *any* access to the card will freeze the machine at this
point.

After manually restoring the PCI configuration data gathered with lspci
-x,
the output of lspci -vvv is identical from before S3. No difference what
so ever.

But:
- running boot_radeon now segfaults instead of freezing the machine
running video_boot does nothing (goes into an endless loop)
switching back to VT7 (X11 w/ radeon driver and DRI)  switches the
backlight
on. XFree86.0.log says:

(II) RADEON(0): Wrote: rd=6, fd=72, pd=4
(II) RADEON(0): [RESUME] Attempting to re-init Radeon hardware.
(II) RADEON(0): [agp] Mode 0x1f000207 [AGP 0x8086/0x3340; Card
0x1002/0x5c63]

The system now suffers under a 100% CPU load. One can not switch back to
VT[1-6].

If I start X after a resume, the log says:
[...]
(II) RADEON(0): Displays Detected: Monitor1--Type 1, Monitor2--Type 0
[...]
which is wrong. Monitor 1 is of Type 2 (LCD), the rest looks normal.

Starting X using the fglrx driver i get:

(EE) fglrx(0): DRIScreenInit failed!
(WW) fglrx(0): ***********************************************
(WW) fglrx(0): * DRI initialization failed!                  *
(WW) fglrx(0): * (maybe driver kernel module missing or bad) *
(WW) fglrx(0): * 2D acceleraton available (MMIO)             *
(WW) fglrx(0): * no 3D acceleration available                *
(WW) fglrx(0): ********************************************* *
(II) fglrx(0): FBADPhys: 0xd8000000 FBMappedSize: 0x08000000

So, looking at the logs, the card almost works. Almost :(


-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-GJc3uf76Xb1V+84vGpXr
Content-Description: 
Content-Disposition: attachment; filename=XFree86.0.log.normal
Content-Type: text/x-log; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86-Mv/r+YdnZeCNvCAlj6F9uA@public.gmane.org and patches submitted
to fixes-Mv/r+YdnZeCyi60V37fsNg@public.gmane.org  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs).

XFree86 Version 4.3.99.902 (4.4.0 RC 2)
Release Date: 18 December 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.2-mm1 i686 [ELF] 
Current Operating System: Linux mhcln03 2.6.9 #1 Wed Nov 24 08:29:51 CET 2004 i686
Build Date: 06 February 2004
Changelog Date: 04 February 2004
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Wed Nov 24 13:51:47 2004
(==) Using config file: "/etc/X11/XF86Config-4"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "Generic Monitor"
(**) |   |-->Device "Generic Video Card"
(**) |-->Input Device "Generic Keyboard"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc105"
(**) XKB: model: "pc105"
(**) Option "XkbLayout" "de"
(**) XKB: layout: "de"
(==) Keyboard: CustomKeycode disabled
(**) |-->Input Device "USB Mouse"
(**) |-->Input Device "Touchpad"
(WW) The directory "/usr/lib/X11/fonts/CID" does not exist.
	Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/cyrillic" does not exist.
	Entry deleted from font path.
(**) FontPath set to "unix/:7100,/usr/lib/X11/fonts/Type1,/usr/lib/X11/fonts/Speedo,/usr/lib/X11/fonts/misc,/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/75dpi"
(==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.2
	XFree86 Video Driver: 0.7
	XFree86 XInput driver : 0.4
	XFree86 Server Extension : 0.2
	XFree86 Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.7
(++) using VT number 7

(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x80021040, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,3340 card 144d,c00c rev 21 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 8086,3341 card 0000,0000 rev 21 class 06,04,00 hdr 01
(II) PCI: 00:1d:0: chip 8086,24c2 card 144d,c00c rev 03 class 0c,03,00 hdr 80
(II) PCI: 00:1d:1: chip 8086,24c4 card 144d,c00c rev 03 class 0c,03,00 hdr 00
(II) PCI: 00:1d:2: chip 8086,24c7 card 144d,c00c rev 03 class 0c,03,00 hdr 00
(II) PCI: 00:1d:7: chip 8086,24cd card 144d,c00c rev 03 class 0c,03,20 hdr 00
(II) PCI: 00:1e:0: chip 8086,2448 card 0000,0000 rev 83 class 06,04,00 hdr 01
(II) PCI: 00:1f:0: chip 8086,24cc card 0000,0000 rev 03 class 06,01,00 hdr 80
(II) PCI: 00:1f:1: chip 8086,24ca card 144d,c00c rev 03 class 01,01,8a hdr 00
(II) PCI: 00:1f:5: chip 8086,24c5 card 144d,c00c rev 03 class 04,01,00 hdr 00
(II) PCI: 00:1f:6: chip 8086,24c6 card 144d,c00c rev 03 class 07,03,00 hdr 00
(II) PCI: 01:00:0: chip 1002,5c63 card 144d,c00c rev 01 class 03,00,00 hdr 00
(II) PCI: 02:00:0: chip 10ec,8139 card 144d,c00c rev 10 class 02,00,00 hdr 00
(II) PCI: 02:01:0: chip 1180,0476 card 4400,0000 rev ac class 06,07,00 hdr 82
(II) PCI: 02:01:1: chip 1180,0476 card 4c00,0000 rev ac class 06,07,00 hdr 82
(II) PCI: 02:01:2: chip 1180,0552 card 144d,c00c rev 04 class 0c,00,10 hdr 80
(II) PCI: 02:02:0: chip 8086,1043 card 8086,2522 rev 04 class 02,80,00 hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,7), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x000c (VGA_EN is set)
(II) Bus 1 I/O range:
	[0] -1	0	0x00003000 - 0x000030ff (0x100) IX[B]
	[1] -1	0	0x00003400 - 0x000034ff (0x100) IX[B]
	[2] -1	0	0x00003800 - 0x000038ff (0x100) IX[B]
	[3] -1	0	0x00003c00 - 0x00003cff (0x100) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0xd0100000 - 0xd01fffff (0x100000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:30:0), (0,2,4), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 2 I/O range:
	[0] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[1] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[2] -1	0	0x00004800 - 0x000048ff (0x100) IX[B]
	[3] -1	0	0x00004c00 - 0x00004cff (0x100) IX[B]
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0	0xd0200000 - 0xd02fffff (0x100000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-CardBus bridge:
(II) Bus 3: bridge is at (2:1:0), (2,3,6), BCTRL: 0x0580 (VGA_EN is cleared)
(II) Bus 3 I/O range:
	[0] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[1] -1	0	0x00004800 - 0x000048ff (0x100) IX[B]
(II) PCI-to-CardBus bridge:
(II) Bus 7: bridge is at (2:1:1), (2,7,10), BCTRL: 0x0580 (VGA_EN is cleared)
(II) Bus 7 I/O range:
	[0] -1	0	0x00004c00 - 0x00004cff (0x100) IX[B]
(--) PCI:*(1:0:0) ATI Technologies Inc unknown chipset (0x5c63) rev 1, Mem @ 0xd8000000/27, 0xd0100000/16, I/O @ 0x3000/8
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) PCI Memory resource overlap reduced 0xe0000000 from 0xefffffff to 0xdfffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xd0200000 - 0xd0200fff (0x1000) MX[B]
	[1] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[2] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[3] -1	0	0xd0000800 - 0xd00008ff (0x100) MX[B]
	[4] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[5] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[6] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[7] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[8] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[9] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[10] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[11] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[12] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[13] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[14] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[15] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[16] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[17] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[18] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[19] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xd0200000 - 0xd0200fff (0x1000) MX[B]
	[1] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[2] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[3] -1	0	0xd0000800 - 0xd00008ff (0x100) MX[B]
	[4] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[5] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[6] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[7] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[8] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[9] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[10] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[11] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[12] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[13] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[14] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[15] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[16] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[17] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[18] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[19] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x1fffffff (0x1ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x1fffffff (0x1ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xd0200000 - 0xd0200fff (0x1000) MX[B]
	[6] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[7] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[8] -1	0	0xd0000800 - 0xd00008ff (0x100) MX[B]
	[9] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[10] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[11] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[12] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[13] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[14] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[15] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[16] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[17] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[18] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[19] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[20] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[21] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[22] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[23] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[24] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[25] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[26] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) LoadModule: "bitmap"
(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Loading font Bitmap
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.7
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project & the After X-TT Project"
	compiled for 4.3.99.902, module version = 2.1.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Reloading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Loading extension GLX
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.7
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.13.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
(II) Module speedo: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.1
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Speedo
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.2
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.1.0
	ABI class: XFree86 Video Driver, version 0.7
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 6.5.5
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.7
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.4
(II) ATI: ATI driver (version 6.5.5) for chipsets: ati, ativga
(II) R128: Driver for ATI Rage 128 chipsets:
	ATI Rage 128 Mobility M3 LE (PCI), ATI Rage 128 Mobility M3 LF (AGP),
	ATI Rage 128 Mobility M4 MF (AGP), ATI Rage 128 Mobility M4 ML (AGP),
	ATI Rage 128 Pro GL PA (PCI/AGP), ATI Rage 128 Pro GL PB (PCI/AGP),
	ATI Rage 128 Pro GL PC (PCI/AGP), ATI Rage 128 Pro GL PD (PCI),
	ATI Rage 128 Pro GL PE (PCI/AGP), ATI Rage 128 Pro GL PF (AGP),
	ATI Rage 128 Pro VR PG (PCI/AGP), ATI Rage 128 Pro VR PH (PCI/AGP),
	ATI Rage 128 Pro VR PI (PCI/AGP), ATI Rage 128 Pro VR PJ (PCI/AGP),
	ATI Rage 128 Pro VR PK (PCI/AGP), ATI Rage 128 Pro VR PL (PCI/AGP),
	ATI Rage 128 Pro VR PM (PCI/AGP), ATI Rage 128 Pro VR PN (PCI/AGP),
	ATI Rage 128 Pro VR PO (PCI/AGP), ATI Rage 128 Pro VR PP (PCI),
	ATI Rage 128 Pro VR PQ (PCI/AGP), ATI Rage 128 Pro VR PR (PCI),
	ATI Rage 128 Pro VR PS (PCI/AGP), ATI Rage 128 Pro VR PT (PCI/AGP),
	ATI Rage 128 Pro VR PU (PCI/AGP), ATI Rage 128 Pro VR PV (PCI/AGP),
	ATI Rage 128 Pro VR PW (PCI/AGP), ATI Rage 128 Pro VR PX (PCI/AGP),
	ATI Rage 128 GL RE (PCI), ATI Rage 128 GL RF (AGP),
	ATI Rage 128 RG (AGP), ATI Rage 128 VR RK (PCI),
	ATI Rage 128 VR RL (AGP), ATI Rage 128 4X SE (PCI/AGP),
	ATI Rage 128 4X SF (PCI/AGP), ATI Rage 128 4X SG (PCI/AGP),
	ATI Rage 128 4X SH (PCI/AGP), ATI Rage 128 4X SK (PCI/AGP),
	ATI Rage 128 4X SL (PCI/AGP), ATI Rage 128 4X SM (AGP),
	ATI Rage 128 4X SN (PCI/AGP), ATI Rage 128 Pro ULTRA TF (AGP),
	ATI Rage 128 Pro ULTRA TL (AGP), ATI Rage 128 Pro ULTRA TR (AGP),
	ATI Rage 128 Pro ULTRA TS (AGP?), ATI Rage 128 Pro ULTRA TT (AGP?),
	ATI Rage 128 Pro ULTRA TU (AGP?)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI Radeon VE/7000 QY (AGP/PCI), ATI Radeon VE/7000 QZ (AGP/PCI),
	ATI Radeon Mobility M7 LW (AGP),
	ATI Mobility FireGL 7800 M7 LX (AGP),
	ATI Radeon Mobility M6 LY (AGP), ATI Radeon Mobility M6 LZ (AGP),
	ATI Radeon IGP320 (A3) 4136, ATI Radeon IGP320M (U1) 4336,
	ATI Radeon IGP330/340/350 (A4) 4137,
	ATI Radeon IGP330M/340M/350M (U2) 4337,
	ATI Radeon 7000 IGP (A4+) 4237, ATI Radeon Mobility 7000 IGP 4437,
	ATI FireGL 8700/8800 QH (AGP), ATI Radeon 8500 QL (AGP),
	ATI Radeon 9100 QM (AGP), ATI Radeon 8500 AIW BB (AGP),
	ATI Radeon 8500 AIW BC (AGP), ATI Radeon 7500 QW (AGP/PCI),
	ATI Radeon 7500 QX (AGP/PCI), ATI Radeon 9000/PRO If (AGP/PCI),
	ATI Radeon 9000 Ig (AGP/PCI), ATI FireGL Mobility 9000 (M9) Ld (AGP),
	ATI Radeon Mobility 9000 (M9) Lf (AGP),
	ATI Radeon Mobility 9000 (M9) Lg (AGP),
	ATI Radeon 9100 IGP (A5) 5834,
	ATI Radeon Mobility 9100 IGP (U3) 5835,
	ATI Radeon 9200PRO 5960 (AGP), ATI Radeon 9200 5961 (AGP),
	ATI Radeon 9200 5962 (AGP), ATI Radeon 9200SE 5964 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C61 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C63 (AGP), ATI Radeon 9500 AD (AGP),
	ATI Radeon 9500 AE (AGP), ATI Radeon 9600TX AF (AGP),
	ATI FireGL Z1 AG (AGP), ATI Radeon 9700 Pro ND (AGP),
	ATI Radeon 9700/9500Pro NE (AGP), ATI Radeon 9700 NF (AGP),
	ATI FireGL X1 NG (AGP), ATI Radeon 9600 AP (AGP),
	ATI Radeon 9600SE AQ (AGP), ATI Radeon 9600XT AR (AGP),
	ATI Radeon 9600 AS (AGP), ATI FireGL T2 AT (AGP),
	ATI FireGL RV360 AV (AGP), ATI Radeon Mobility 9600 (M10) NP (AGP),
	ATI Radeon Mobility 9600 (M10) NQ (AGP),
	ATI Radeon Mobility 9600 (M11) NR (AGP),
	ATI Radeon Mobility 9600 (M10) NS (AGP),
	ATI FireGL Mobility T2 (M10) NT (AGP),
	ATI FireGL Mobility T2 (M11) NV (AGP), ATI Radeon 9800SE AH (AGP),
	ATI Radeon 9800 AI (AGP), ATI Radeon 9800 AJ (AGP),
	ATI FireGL X2 AK (AGP), ATI Radeon 9800PRO NH (AGP),
	ATI Radeon 9800 NI (AGP), ATI FireGL X2 NK (AGP),
	ATI Radeon 9800XT NJ (AGP)
(II) Primary Device is: PCI 01:00:0
(II) ATI:  Candidate "Device" section "Generic Video Card".
(--) Assigning device section with no busID to primary device
(--) Chipset ATI Radeon Mobility 9200 (M9+) 5C63 (AGP) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x1fffffff (0x1ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xd0200000 - 0xd0200fff (0x1000) MX[B]
	[6] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[7] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[8] -1	0	0xd0000800 - 0xd00008ff (0x100) MX[B]
	[9] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[10] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[11] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[12] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[13] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[14] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[15] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[16] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[17] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[18] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[19] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[20] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[21] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[22] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[23] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[24] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[25] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[26] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) Loading sub module "radeon"
(II) LoadModule: "radeon"
(II) Loading /usr/X11R6/lib/modules/drivers/radeon_drv.o
(II) Module radeon: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 4.0.1
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.7
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x1fffffff (0x1ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xd0200000 - 0xd0200fff (0x1000) MX[B]
	[6] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[7] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[8] -1	0	0xd0000800 - 0xd00008ff (0x100) MX[B]
	[9] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[10] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[11] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[12] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[13] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[14] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[15] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[16] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[17] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[18] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[19] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[20] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[21] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[22] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[23] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[24] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[25] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[26] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[27] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[28] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[29] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[30] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[31] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) RADEON(0): MMIO registers at 0xd0100000
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.7
(II) RADEON(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(II) RADEON(0): PCI bus 1 card 0 func 0
(**) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(**) RADEON(0): Option "AGPMode" "4"
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
(II) RADEON(0): initializing int10
(II) RADEON(0): Primary V_BIOS segment is: 0xc000
(--) RADEON(0): Chipset: "ATI Radeon Mobility 9200 (M9+) 5C63 (AGP)" (ChipID = 0x5c63)
(--) RADEON(0): Linear framebuffer at 0xd8000000
(--) RADEON(0): VideoRAM: 32768 kByte (64 bit DDR SDRAM)
(II) RADEON(0): AGP card detected
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.a
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.2.0
	ABI class: XFree86 Video Driver, version 0.7
(II) RADEON(0): I2C bus "DDC" initialized.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 2, Detected Type: 0
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 4, Detected Type: 0
(II) RADEON(0): Non-DDC laptop panel detected
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 3, Detected Type: 0
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 4, Detected Type: 0
(II) RADEON(0): Displays Detected: Monitor1--Type 2, Monitor2--Type 0

(II) RADEON(0): 
(II) RADEON(0): Primary Display == Type 2
(II) RADEON(0): Panel ID string: Samsung LTN150P1-L02    
(II) RADEON(0): Panel Size from BIOS: 1400x1050
(II) RADEON(0): BIOS provided dividers will be used.
(==) RADEON(0): Using gamma correction (1.0, 1.0, 1.0)
(II) RADEON(0): Validating modes on Primary head ---------
(II) RADEON(0): Total number of valid DDC mode(s) found: 0
(II) RADEON(0): Valid mode using on-chip RMX: 1400x1050
(II) RADEON(0): Valid mode using on-chip RMX: 1280x1024
(II) RADEON(0): Valid mode using on-chip RMX: 1280x960
(II) RADEON(0): Valid mode using on-chip RMX: 1024x768
(II) RADEON(0): Valid mode using on-chip RMX: 800x600
(II) RADEON(0): Valid mode using on-chip RMX: 640x480
(II) RADEON(0): Total number of valid FP mode(s) found: 6
(--) RADEON(0): Virtual size is 1400x1050 (pitch 1408)
(**) RADEON(0): *Mode "1400x1050": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "1400x1050"  108.00  1400 34208 34320 1688  1050 1052 1055 1063
(**) RADEON(0): *Mode "1280x1024": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "1280x1024"  108.00  1280 34208 34320 1688  1024 1052 1055 1063
(**) RADEON(0): *Mode "1280x960": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "1280x960"  108.00  1280 34208 34320 1688  960 1052 1055 1063
(**) RADEON(0): *Mode "1024x768": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "1024x768"  108.00  1024 34208 34320 1688  768 1052 1055 1063
(**) RADEON(0): *Mode "800x600": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "800x600"  108.00  800 34208 34320 1688  600 1052 1055 1063
(**) RADEON(0): *Mode "640x480": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "640x480"  108.00  640 34208 34320 1688  480 1052 1055 1063
(**) RADEON(0):  Default mode "640x350": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "640x350"  108.00  640 34208 34320 1688  350 1052 1055 1063
(**) RADEON(0):  Default mode "640x400": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "640x400"  108.00  640 34208 34320 1688  400 1052 1055 1063
(**) RADEON(0):  Default mode "720x400": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "720x400"  108.00  720 34208 34320 1688  400 1052 1055 1063
(**) RADEON(0):  Default mode "1152x864": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "1152x864"  108.00  1152 34208 34320 1688  864 1052 1055 1063
(**) RADEON(0):  Default mode "832x624": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "832x624"  108.00  832 34208 34320 1688  624 1052 1055 1063
(**) RADEON(0):  Default mode "1152x768": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "1152x768"  108.00  1152 34208 34320 1688  768 1052 1055 1063
(==) RADEON(0): DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.7
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.1.0
	ABI class: XFree86 Video Driver, version 0.7
(**) RADEON(0): Using AGP 4x mode
(II) RADEON(0): AGP Fast Write disabled by default
(II) RADEON(0): Depth moves disabled by default
(II) Loading sub module "shadowfb"
(II) LoadModule: "shadowfb"
(II) Loading /usr/X11R6/lib/modules/libshadowfb.a
(II) Module shadowfb: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(II) RADEON(0): Page flipping disabled
(!!) RADEON(0): For information on using the multimedia capabilities
 of this adapter, please see http://gatos.sf.net.
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0xd0100000 - 0xd010ffff (0x10000) MX[B]
	[1] 0	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B]
	[2] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[3] -1	0	0x00100000 - 0x1fffffff (0x1ff00000) MX[B]E(B)
	[4] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[5] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[6] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[7] -1	0	0xd0200000 - 0xd0200fff (0x1000) MX[B]
	[8] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[9] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[10] -1	0	0xd0000800 - 0xd00008ff (0x100) MX[B]
	[11] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[12] -1	0	0x20000000 - 0x200003ff (0x400) MX[B]
	[13] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[14] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[15] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[16] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[17] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B](OprU)
	[18] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprU)
	[19] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B](OprU)
	[20] 0	0	0x00003000 - 0x000030ff (0x100) IX[B]
	[21] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[22] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[23] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[24] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[25] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[26] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[27] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[28] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[29] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[30] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[31] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[32] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[33] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B](OprU)
	[34] 0	0	0x000003c0 - 0x000003df (0x20) IS[B](OprU)
(WW) RADEON(0): Failed to set up write-combining range (0xd8000000,0x2000000)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 5, (OK)
drmGetBusid returned ''
(II) RADEON(0): [drm] loaded kernel module for "radeon" driver
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:1:0:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe0b9b000
(II) RADEON(0): [drm] mapped SAREA 0xe0b9b000 to 0xb5d7d000
(II) RADEON(0): [drm] framebuffer handle = 0xd8000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [agp] Mode 0x1f000207 [AGP 0x8086/0x3340; Card 0x1002/0x5c63]
(II) RADEON(0): [agp] 8192 kB allocated with handle 0x00000001
(II) RADEON(0): [agp] ring handle = 0xe0000000
(II) RADEON(0): [agp] Ring mapped at 0xb5c7c000
(II) RADEON(0): [agp] ring read ptr handle = 0xe0101000
(II) RADEON(0): [agp] Ring read ptr mapped at 0xb5c7b000
(II) RADEON(0): [agp] vertex/indirect buffers handle = 0xe0102000
(II) RADEON(0): [agp] Vertex/indirect buffers mapped at 0xb5a7b000
(II) RADEON(0): [agp] GART texture map handle = 0xe0302000
(II) RADEON(0): [agp] GART Texture map mapped at 0xb559b000
(II) RADEON(0): [drm] register handle = 0xd0100000
(II) RADEON(0): [dri] Visual configs initialized
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB GART aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for GART textures
(II) RADEON(0): Memory manager initialized to (0,0) (1408,5957)
(II) RADEON(0): Reserved area from (0,1050) to (1408,1052)
(II) RADEON(0): Largest offscreen area available: 1408 x 4905
(II) RADEON(0): Will use back buffer at offset 0xb70000
(II) RADEON(0): Will use depth buffer at offset 0x1114000
(II) RADEON(0): Will use 9472 kb for textures at offset 0x16c0000
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Scanline Image Writes
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		32 256x256 slots
		15 512x512 slots
(II) RADEON(0): Acceleration enabled
(==) RADEON(0): Backing store disabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using hardware cursor (scanline 1052)
(II) RADEON(0): Largest offscreen area available: 1408 x 4902
(**) Option "dpms"
(**) RADEON(0): DPMS enabled
(II) RADEON(0): X context handle = 0x00000001
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete
(II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers
(II) RADEON(0): [drm] Mapped 32 vertex/indirect buffers
(II) RADEON(0): [drm] dma control initialized, using IRQ 5
(II) RADEON(0): [drm] Initialized kernel GART heap manager, 5111808
(II) RADEON(0): Direct rendering enabled
(==) RandR enabled
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Keyboard "Generic Keyboard" handled by legacy driver
(**) Option "Protocol" "ImPS/2"
(**) USB Mouse: Device: "/dev/input/mice"
(**) USB Mouse: Protocol: "ImPS/2"
(**) Option "CorePointer"
(**) USB Mouse: Core Pointer
(**) Option "Device" "/dev/input/mice"
(**) USB Mouse: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) USB Mouse: ZAxisMapping: buttons 4 and 5
(**) USB Mouse: Buttons: 5
(**) Option "Protocol" "ImPS/2"
(**) Touchpad: Device: "/dev/psaux"
(**) Touchpad: Protocol: "ImPS/2"
(**) Option "Device" "/dev/psaux"
(**) Option "Emulate3Buttons" "true"
(**) Touchpad: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Touchpad: ZAxisMapping: buttons 4 and 5
(**) Touchpad: Buttons: 5
(II) XINPUT: Adding extended input device "Touchpad" (type: MOUSE)
(II) XINPUT: Adding extended input device "USB Mouse" (type: MOUSE)
(II) USB Mouse: ps2EnableDataReporting: succeeded
Warning: font renderer for ".pcf" already registered at priority 0
Warning: font renderer for ".pcf.Z" already registered at priority 0
Warning: font renderer for ".pcf.gz" already registered at priority 0
Warning: font renderer for ".snf" already registered at priority 0
Warning: font renderer for ".snf.Z" already registered at priority 0
Warning: font renderer for ".snf.gz" already registered at priority 0
Warning: font renderer for ".bdf" already registered at priority 0
Warning: font renderer for ".bdf.Z" already registered at priority 0
Warning: font renderer for ".bdf.gz" already registered at priority 0
Warning: font renderer for ".pmf" already registered at priority 0
(II) Touchpad: ps2EnableDataReporting: succeeded
GetModeLine - scrn: 0 clock: 108000
GetModeLine - hdsp: 1400 hbeg: 34208 hend: 34320 httl: 1688
              vdsp: 1050 vbeg: 1052 vend: 1055 vttl: 1063 flags: -2147483648
(II) 3rd Button detected: disabling emulate3Button

--=-GJc3uf76Xb1V+84vGpXr
Content-Disposition: attachment; filename=XFree86.0.log.fglrx.resume
Content-Type: text/plain; name=XFree86.0.log.fglrx.resume; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86-Mv/r+YdnZeCNvCAlj6F9uA@public.gmane.org and patches submitted
to fixes-Mv/r+YdnZeCyi60V37fsNg@public.gmane.org  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs).

XFree86 Version 4.3.99.902 (4.4.0 RC 2)
Release Date: 18 December 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.2-mm1 i686 [ELF] 
Current Operating System: Linux mhcln03 2.6.10-rc2-mm3pci_resume #2 Tue Nov 23 08:38:51 CET 2004 i686
Build Date: 06 February 2004
Changelog Date: 04 February 2004
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Tue Nov 23 09:07:58 2004
(==) Using config file: "/etc/X11/XF86Config-4"
(==) ServerLayout "Server Layout"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "LCD"
(**) |   |-->Device "ATI Graphics Adapter"
(**) |-->Input Device "USB Mouse"
(**) |-->Input Device "Touchpad"
(**) |-->Input Device "Keyboard"
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc105"
(**) XKB: model: "pc105"
(**) Option "XkbLayout" "de"
(**) XKB: layout: "de"
(**) Option "XkbVariant" "nodeadkeys"
(**) XKB: variant: "nodeadkeys"
(==) Keyboard: CustomKeycode disabled
(WW) Duplicate core pointer devices.  Removing core pointer attribute from "Touchpad"
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.2
	XFree86 Video Driver: 0.7
	XFree86 XInput driver : 0.4
	XFree86 Server Extension : 0.2
	XFree86 Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.7
(++) using VT number 8

(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x00000000, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,3340 card 144d,c00c rev 21 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 8086,3341 card 0000,0000 rev 21 class 06,04,00 hdr 01
(II) PCI: 00:1d:0: chip 8086,24c2 card 144d,c00c rev 03 class 0c,03,00 hdr 80
(II) PCI: 00:1d:1: chip 8086,24c4 card 144d,c00c rev 03 class 0c,03,00 hdr 00
(II) PCI: 00:1d:2: chip 8086,24c7 card 144d,c00c rev 03 class 0c,03,00 hdr 00
(II) PCI: 00:1d:7: chip 8086,24cd card 144d,c00c rev 03 class 0c,03,20 hdr 00
(II) PCI: 00:1e:0: chip 8086,2448 card 0000,0000 rev 83 class 06,04,00 hdr 01
(II) PCI: 00:1f:0: chip 8086,24cc card 0000,0000 rev 03 class 06,01,00 hdr 80
(II) PCI: 00:1f:1: chip 8086,24ca card 144d,c00c rev 03 class 01,01,8a hdr 00
(II) PCI: 00:1f:5: chip 8086,24c5 card 144d,c00c rev 03 class 04,01,00 hdr 00
(II) PCI: 00:1f:6: chip 8086,24c6 card 144d,c00c rev 03 class 07,03,00 hdr 00
(II) PCI: 01:00:0: chip 1002,5c63 card 144d,c00c rev 01 class 03,00,00 hdr 00
(II) PCI: 02:00:0: chip 10ec,8139 card 144d,c00c rev 10 class 02,00,00 hdr 00
(II) PCI: 02:01:0: chip 1180,0476 card 0000,0000 rev ac class 06,07,00 hdr 82
(II) PCI: 02:01:1: chip 1180,0476 card 0000,0000 rev ac class 06,07,00 hdr 82
(II) PCI: 02:01:2: chip 1180,0552 card 144d,c00c rev 04 class 0c,00,10 hdr 80
(II) PCI: 02:02:0: chip 8086,1043 card 8086,2522 rev 04 class 02,80,00 hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,7), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:30:0), (0,2,4), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 2 I/O range:
	[0] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[1] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[2] -1	0	0x00004800 - 0x000048ff (0x100) IX[B]
	[3] -1	0	0x00004c00 - 0x00004cff (0x100) IX[B]
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0	0xd0200000 - 0xd02fffff (0x100000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-CardBus bridge:
(II) Bus 3: bridge is at (2:1:0), (2,3,6), BCTRL: 0x0780 (VGA_EN is cleared)
(II) PCI-to-CardBus bridge:
(II) Bus 7: bridge is at (2:1:1), (2,7,10), BCTRL: 0x0700 (VGA_EN is cleared)
(--) PCI:*(1:0:0) ATI Technologies Inc unknown chipset (0x5c63) rev 1, Mem @ 0xd8000000/27, 0xd0100000/16, I/O @ 0x3000/8
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) PCI Memory resource overlap reduced 0xe0000000 from 0xefffffff to 0xdfffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[1] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[2] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[3] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[4] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[5] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[6] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[7] -1	0	0x00001500 - 0x0000157f (0x80) IX[B]
	[8] -1	0	0x00001400 - 0x000014ff (0x100) IX[B]
	[9] -1	0	0x00001300 - 0x0000133f (0x40) IX[B]
	[10] -1	0	0x00001200 - 0x000012ff (0x100) IX[B]
	[11] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[12] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[13] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[14] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[15] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[1] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[2] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[3] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[4] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[5] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[6] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[7] -1	0	0x00001500 - 0x0000157f (0x80) IX[B]
	[8] -1	0	0x00001400 - 0x000014ff (0x100) IX[B]
	[9] -1	0	0x00001300 - 0x0000133f (0x40) IX[B]
	[10] -1	0	0x00001200 - 0x000012ff (0x100) IX[B]
	[11] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[12] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[13] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[14] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[15] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[6] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[7] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[8] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[9] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[10] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[11] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[12] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[13] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[14] -1	0	0x00001500 - 0x0000157f (0x80) IX[B]
	[15] -1	0	0x00001400 - 0x000014ff (0x100) IX[B]
	[16] -1	0	0x00001300 - 0x0000133f (0x40) IX[B]
	[17] -1	0	0x00001200 - 0x000012ff (0x100) IX[B]
	[18] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[19] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[20] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[21] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[22] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.2
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project & the After X-TT Project"
	compiled for 4.3.99.902, module version = 2.1.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "fglrx"
(II) Loading /usr/X11R6/lib/modules/drivers/fglrx_drv.o
(II) Module fglrx: vendor="Fire GL - ATI Research GmbH, Germany"
	compiled for 4.3.0.1, module version = 3.14.1
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.4
(II) FireGL8700/8800: Driver for chipset: ATI RV250 Id (R9000),
	ATI RV250 Ie (R9000), ATI RV250 If (R9000), ATI RV250 Ig (R9000),
	ATI RV250 Ld (M9), ATI RV250 Le (M9), ATI RV250 Lf (M9),
	ATI RV250 Lg (M9), ATI RV280 5960 (R9200 PRO),
	ATI RV280 Ya (R9200LE), ATI RV250SE Yd (R9200SE),
	ATI RV250 5C61 (M9+), ATI RV250 5C63 (M9+), ATI R200 QH (R8500),
	ATI R200 QL (R8500), ATI R200 QM (R9100), ATI R200 QT (R8500),
	ATI R200 QU (R9100), ATI R200 BB (R8500), ATI RV350 AP (R9600),
	ATI RV350SE AQ (R9600SE), ATI RV350 AR (R9600 PRO),
	ATI RV350 NP (M10), ATI R300 AD (R9500), ATI R300 AE (R9500),
	ATI R300 AF (R9500), ATI R300 AG (Fire GL Z1/X1),
	ATI R300 ND (R9700 PRO), ATI R300 NE (R9700/R9500 PRO),
	ATI R300 NF (R9600 TX), ATI R300 NG (Fire GL X1),
	ATI R350SE AH (R9800SE), ATI R350 AK (Fire GL unknown),
	ATI RV350 AS (Fire GL T2), ATI RV350 AT (Fire GL T2),
	ATI RV350 AU (Fire GL T2), ATI RV350 AV (Fire GL T2),
	ATI RV350 AW (Fire GL T2), ATI R350 NH (R9800),
	ATI R350LE NI (R9800LE), ATI R350 NJ (R9800),
	ATI R350 NK (Fire GL X2), ATI RV350 NT (WS/M10), ATI RV370 5B60,
	ATI RV370 5B61, ATI RV370 5B62, ATI RV370 5B63, ATI RV370 5B64,
	ATI RV370 5B66, ATI RV370 5B67, ATI RV370 5B70, ATI RV370 5B71,
	ATI RV370 5B72, ATI RV370 5B73, ATI RV370 5460, ATI RV370 5461,
	ATI RV370 5462, ATI RV370 5463, ATI RV370 5464, ATI RV370 5465,
	ATI RV370 5466, ATI RV370 5467, ATI RV370 5470, ATI RV370 5471,
	ATI RV370 5472, ATI RV370 5473, ATI RV380 AP, ATI RV380 AQ,
	ATI RV380 AR, ATI RV380 AS, ATI RV380 AT, ATI RV380 AU, ATI RV380 AV,
	ATI RV380 AW, ATI RV380 AP2, ATI RV380 AQ2, ATI RV380 AR2,
	ATI RV380 AS2, ATI RV380 NP, ATI RV380 NQ, ATI RV380 NR,
	ATI RV380 NS, ATI RV380 NT, ATI RV380 NU, ATI RV380 NV, ATI RV380 NW,
	ATI RV380 NP2, ATI RV380 NQ2, ATI RV380 NR2, ATI RV380 NS2,
	ATI R420 JH, ATI R420 JI, ATI R420 JJ, ATI R420 JK, ATI R420 JL,
	ATI R420 JM, ATI R420 JN, ATI R420 JP, ATI R423 UH, ATI R423 UI,
	ATI R423 UJ, ATI R423 UK, ATI R423 UL, ATI R423 UM, ATI R423 ]W,
	ATI R423 UP, ATI R423 UQ, ATI R423 UR, ATI R423 UT, ATI R423 ]H,
	ATI R423 ]I, ATI RV410 VJ, ATI RV410 VK, ATI RV410 VL, ATI RV410 VM,
	ATI RV410 ^H, ATI RV410 ^I, ATI RV410 ^J, ATI RV410 ^K, ATI RV410 ^L,
	ATI RV410 ^M, ATI RV410 ^O, ATI RV410 VR, ATI RV410 VS, ATI RV410 ^R,
	ATI RV410 ^S, ATI RV410 ^U, ATI RS300 IGP, ATI RS350 IGP,
	ATI RS300M IGP
(II) Primary Device is: PCI 01:00:0
(--) Chipset ATI RV250 5C63 (M9+) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[6] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[7] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[8] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[9] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[10] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[11] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[12] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[13] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[14] -1	0	0x00001500 - 0x0000157f (0x80) IX[B]
	[15] -1	0	0x00001400 - 0x000014ff (0x100) IX[B]
	[16] -1	0	0x00001300 - 0x0000133f (0x40) IX[B]
	[17] -1	0	0x00001200 - 0x000012ff (0x100) IX[B]
	[18] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[19] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[20] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[21] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[22] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) fglrx(0): pEnt->device->identifier=0x8209438
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[6] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[7] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[8] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[9] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[10] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[11] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[12] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[13] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[14] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[15] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[16] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[17] -1	0	0x00001500 - 0x0000157f (0x80) IX[B]
	[18] -1	0	0x00001400 - 0x000014ff (0x100) IX[B]
	[19] -1	0	0x00001300 - 0x0000133f (0x40) IX[B]
	[20] -1	0	0x00001200 - 0x000012ff (0x100) IX[B]
	[21] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[22] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[23] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[24] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[25] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[26] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[27] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) fglrx(0): === [R200PreInit] === begin, [s]
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.7
(II) fglrx(0): PCI bus 1 card 0 func 0
(**) fglrx(0): Depth 24, (--) framebuffer bpp 32
(II) fglrx(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) fglrx(0): Default visual is TrueColor
(**) fglrx(0): Option "NoAccel" "no"
(**) fglrx(0): Option "NoDRI" "no"
(**) fglrx(0): Option "Capabilities" "0x00000000"
(**) fglrx(0): Option "GammaCorrectionI" "0x00000000"
(**) fglrx(0): Option "GammaCorrectionII" "0x00000000"
(**) fglrx(0): Option "OpenGLOverlay" "off"
(**) fglrx(0): Option "VideoOverlay" "on"
(**) fglrx(0): Option "DesktopSetup" "0x00000100"
(**) fglrx(0): Option "MonitorLayout" "AUTO, NONE"
(**) fglrx(0): Option "HSync2" "unspecified"
(**) fglrx(0): Option "VRefresh2" "unspecified"
(**) fglrx(0): Option "ScreenOverlap" "0"
(**) fglrx(0): Option "IgnoreEDID" "off"
(**) fglrx(0): Option "UseInternalAGPGART" "yes"
(**) fglrx(0): Option "Stereo" "off"
(**) fglrx(0): Option "StereoSyncEnable" "1"
(**) fglrx(0): Option "UseFastTLS" "0"
(**) fglrx(0): Option "BlockSignalsOnLock" "on"
(**) fglrx(0): Option "ForceGenericCPU" "no"
(**) fglrx(0): Option "CenterMode" "off"
(**) fglrx(0): Option "FSAAScale" "1"
(**) fglrx(0): Option "FSAAEnable" "no"
(**) fglrx(0): Option "FSAADisableGamma" "no"
(**) fglrx(0): Option "FSAACustomizeMSPos" "no"
(**) fglrx(0): Option "FSAAMSPosX0" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY0" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX1" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY1" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX2" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY2" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX3" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY3" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX4" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY4" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX5" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY5" "0.000000"
(**) fglrx(0): Option "NoTV" "yes"
(**) fglrx(0): Option "TVStandard" "NTSC-M"
(**) fglrx(0): Option "TVHSizeAdj" "0"
(**) fglrx(0): Option "TVVSizeAdj" "0"
(**) fglrx(0): Option "TVHPosAdj" "0"
(**) fglrx(0): Option "TVVPosAdj" "0"
(**) fglrx(0): Option "TVHStartAdj" "0"
(**) fglrx(0): Option "TVColorAdj" "0"
(**) fglrx(0): Option "PseudoColorVisuals" "off"
(**) fglrx(0): Qbs disabled
(==) fglrx(0): RGB weight 888
(II) fglrx(0): Using 8 bits per RGB (8 bit DAC)
(**) fglrx(0): Gamma Correction for I is 0x00000000
(**) fglrx(0): Gamma Correction for II is 0x00000000
(==) fglrx(0): Buffer Tiling is ON
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.7
(II) fglrx(0): initializing int10
(II) fglrx(0): Primary V_BIOS segment is: 0xc000
(**) fglrx(0): Option "mtrr" "off"
(--) fglrx(0): Chipset: "ATI RV250 5C63 (M9+)" (Chipset = 0x5c63)
(--) fglrx(0): (PciSubVendor = 0x144d, PciSubDevice = 0xc00c)
(--) fglrx(0): board vendor info: third party grafics adapter - NOT original ATI
(--) fglrx(0): Linear framebuffer (phys) at 0xd8000000
(--) fglrx(0): MMIO registers at 0xd0100000
(--) fglrx(0): ChipExtRevID = 0xFF
(--) fglrx(0): ChipIntRevID = 0x0F
(--) fglrx(0): VideoRAM: 131072 kByte (64-bit SDR SDRAM)
(WW) fglrx(0): board is an unknown third party board, chipset is supported
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.7
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.2.0
	ABI class: XFree86 Video Driver, version 0.7
(II) fglrx(0): I2C bus "DDC" initialized.
(II) fglrx(0): Connector Layout from BIOS -------- 
(II) fglrx(0): Connector1: DDCType-3, DACType-0, TMDSType--1, ConnectorType-2
(**) fglrx(0): MonitorLayout Option: 
	Monitor1--Type AUTO, Monitor2--Type NONE

(II) fglrx(0): Primary head:
 Monitor   -- LVDS
 Connector -- None
 DAC Type  -- Unknown
 TMDS Type -- NONE
 DDC Type  -- NONE
(II) fglrx(0): Secondary head:
 Monitor   -- NONE
 Connector -- VGA
 DAC Type  -- Primary
 TMDS Type -- NONE
 DDC Type  -- VGA_DDC
(II) fglrx(0): 
(WW) fglrx(0): Only single display is connected, DesktopOption will be ignored
(II) fglrx(0): DesktopSetup 0x0000
(II) fglrx(0): Panel ID string: Samsung LTN150P1-L02    
(II) fglrx(0): Panel Size from BIOS: 1400x1050
(**) fglrx(0):  PseudoColor visuals disabled
(**) fglrx(0): Overlay disabled
(**) fglrx(0): Overlay disabled
(II) fglrx(0): PLL parameters: rf=2700 rd=12 min=20000 max=40000
(==) fglrx(0): Using gamma correction (1.0, 1.0, 1.0)
(**) fglrx(0): Center Mode is disabled 
(==) fglrx(0): TMDS coherent mode is enabled 
(II) fglrx(0): Valid mode using on-chip RMX: 1400x1050
(II) fglrx(0): Total 1 valid mode(s) found.
(--) fglrx(0): Virtual size is 1400x1050 (pitch 1408)
(**) fglrx(0): *Mode "1400x1050": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) fglrx(0): Modeline "1400x1050"  108.00  1400 34208 34320 1688  1050 1052 1055 1063
(==) fglrx(0): DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.7
(**) fglrx(0): NoAccel = NO
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.1.0
	ABI class: XFree86 Video Driver, version 0.7
(==) fglrx(0): HPV inactive
(==) fglrx(0): FSAA enabled: NO
(**) fglrx(0): FSAA Gamma enabled
(**) fglrx(0): FSAA Multisample Position is fix
(**) fglrx(0): NoDRI = NO
(II) Loading sub module "fglrxdrm"
(II) LoadModule: "fglrxdrm"
(II) Loading /usr/X11R6/lib/modules/linux/libfglrxdrm.a
(II) Module fglrxdrm: vendor="Fire GL - ATI Research GmbH, Germany"
	compiled for 4.3.0.1, module version = 3.14.1
	ABI class: XFree86 Server Extension, version 0.2
(II) fglrx(0): Depth moves disabled by default
(**) fglrx(0): Capabilities: 0x00000000
(**) fglrx(0): cpuFlags: 0x8000001d
(**) fglrx(0): cpuSpeedMHz: 0x000005d7
(==) fglrx(0): OpenGL ClientDriverName: "fglrx_dri.so"
(**) fglrx(0): using built in AGPGART module: yes
(**) fglrx(0): UseFastTLS=0
(**) fglrx(0): BlockSignalsOnLock=1
(==) fglrx(0): EnablePrivateBackZ = NO
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0xd0100000 - 0xd010ffff (0x10000) MX[B]
	[1] 0	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B]
	[2] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[3] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[4] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[5] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[6] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[7] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[8] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[9] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[10] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[11] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[12] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[13] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[14] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[15] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[16] 0	0	0x00003000 - 0x000030ff (0x100) IX[B]
	[17] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[18] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[19] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[20] -1	0	0x00001500 - 0x0000157f (0x80) IX[B]
	[21] -1	0	0x00001400 - 0x000014ff (0x100) IX[B]
	[22] -1	0	0x00001300 - 0x0000133f (0x40) IX[B]
	[23] -1	0	0x00001200 - 0x000012ff (0x100) IX[B]
	[24] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[25] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[26] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[27] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[28] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[29] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[30] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(WW) fglrx(0): Cannot read colourmap from VGA.  Will restore with default
(II) fglrx(0): UMM area:     0xd87ad000 (size=0x07853000)
(II) fglrx(0): driver needs XFree86 version: 4.3.x
(II) fglrx(0): detected XFree86 version: 4.3.99
(II) Loading extension ATIFGLRXDRI
(II) fglrx(0): doing DRIScreenInit
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
[drm] failed to load kernel module "fglrx"
(II) fglrx(0): [drm] drmOpen failed
(EE) fglrx(0): DRIScreenInit failed!
(WW) fglrx(0): ***********************************************
(WW) fglrx(0): * DRI initialization failed!                  *
(WW) fglrx(0): * (maybe driver kernel module missing or bad) *
(WW) fglrx(0): * 2D acceleraton available (MMIO)             *
(WW) fglrx(0): * no 3D acceleration available                *
(WW) fglrx(0): ********************************************* *
(II) fglrx(0): FBADPhys: 0xd8000000 FBMappedSize: 0x08000000

--=-GJc3uf76Xb1V+84vGpXr
Content-Description: 
Content-Disposition: attachment; filename=XFree86.0.log.radeon.resume
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86-Mv/r+YdnZeCNvCAlj6F9uA@public.gmane.org and patches submitted
to fixes-Mv/r+YdnZeCyi60V37fsNg@public.gmane.org  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs).

XFree86 Version 4.3.99.902 (4.4.0 RC 2)
Release Date: 18 December 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.2-mm1 i686 [ELF] 
Current Operating System: Linux mhcln03 2.6.10-rc2-bk4 #5 Tue Nov 23 04:47:31 CET 2004 i686
Build Date: 06 February 2004
Changelog Date: 04 February 2004
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Tue Nov 23 05:08:25 2004
(==) Using config file: "/etc/X11/XF86Config-4"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "Generic Monitor"
(**) |   |-->Device "Generic Video Card"
(**) |-->Input Device "Generic Keyboard"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc105"
(**) XKB: model: "pc105"
(**) Option "XkbLayout" "de"
(**) XKB: layout: "de"
(==) Keyboard: CustomKeycode disabled
(**) |-->Input Device "USB Mouse"
(**) |-->Input Device "Touchpad"
(WW) The directory "/usr/lib/X11/fonts/CID" does not exist.
	Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/cyrillic" does not exist.
	Entry deleted from font path.
(**) FontPath set to "unix/:7100,/usr/lib/X11/fonts/Type1,/usr/lib/X11/fonts/Speedo,/usr/lib/X11/fonts/misc,/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/75dpi"
(==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.2
	XFree86 Video Driver: 0.7
	XFree86 XInput driver : 0.4
	XFree86 Server Extension : 0.2
	XFree86 Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.7
(++) using VT number 7

(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x80010014, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,3340 card 144d,c00c rev 21 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 8086,3341 card 0000,0000 rev 21 class 06,04,00 hdr 01
(II) PCI: 00:1d:0: chip 8086,24c2 card 144d,c00c rev 03 class 0c,03,00 hdr 80
(II) PCI: 00:1d:1: chip 8086,24c4 card 144d,c00c rev 03 class 0c,03,00 hdr 00
(II) PCI: 00:1d:2: chip 8086,24c7 card 144d,c00c rev 03 class 0c,03,00 hdr 00
(II) PCI: 00:1d:7: chip 8086,24cd card 144d,c00c rev 03 class 0c,03,20 hdr 00
(II) PCI: 00:1e:0: chip 8086,2448 card 0000,0000 rev 83 class 06,04,00 hdr 01
(II) PCI: 00:1f:0: chip 8086,24cc card 0000,0000 rev 03 class 06,01,00 hdr 80
(II) PCI: 00:1f:1: chip 8086,24ca card 144d,c00c rev 03 class 01,01,8a hdr 00
(II) PCI: 00:1f:5: chip 8086,24c5 card 144d,c00c rev 03 class 04,01,00 hdr 00
(II) PCI: 00:1f:6: chip 8086,24c6 card 144d,c00c rev 03 class 07,03,00 hdr 00
(II) PCI: 01:00:0: chip 1002,5c63 card 144d,c00c rev 01 class 03,00,00 hdr 00
(II) PCI: 02:00:0: chip 10ec,8139 card 144d,c00c rev 10 class 02,00,00 hdr 00
(II) PCI: 02:01:0: chip 1180,0476 card 0000,0000 rev ac class 06,07,00 hdr 82
(II) PCI: 02:01:1: chip 1180,0476 card 0000,0000 rev ac class 06,07,00 hdr 82
(II) PCI: 02:01:2: chip 1180,0552 card 144d,c00c rev 04 class 0c,00,10 hdr 80
(II) PCI: 02:02:0: chip 8086,1043 card 8086,2522 rev 04 class 02,80,00 hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,7), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x000c (VGA_EN is set)
(II) Bus 1 I/O range:
	[0] -1	0	0x00003000 - 0x000030ff (0x100) IX[B]
	[1] -1	0	0x00003400 - 0x000034ff (0x100) IX[B]
	[2] -1	0	0x00003800 - 0x000038ff (0x100) IX[B]
	[3] -1	0	0x00003c00 - 0x00003cff (0x100) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0xd0100000 - 0xd01fffff (0x100000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:30:0), (0,2,4), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 2 I/O range:
	[0] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[1] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[2] -1	0	0x00004800 - 0x000048ff (0x100) IX[B]
	[3] -1	0	0x00004c00 - 0x00004cff (0x100) IX[B]
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0	0xd0200000 - 0xd02fffff (0x100000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-CardBus bridge:
(II) Bus 3: bridge is at (2:1:0), (2,3,6), BCTRL: 0x0780 (VGA_EN is cleared)
(II) PCI-to-CardBus bridge:
(II) Bus 7: bridge is at (2:1:1), (2,7,10), BCTRL: 0x0700 (VGA_EN is cleared)
(--) PCI:*(1:0:0) ATI Technologies Inc unknown chipset (0x5c63) rev 1, Mem @ 0xd8000000/27, 0xd0100000/16, I/O @ 0x3000/8
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) PCI Memory resource overlap reduced 0xe0000000 from 0xefffffff to 0xdfffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[1] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[2] -1	0	0x00000800 - 0x000008ff (0x100) MX[B]
	[3] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[4] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[5] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[6] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[7] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[8] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[9] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[10] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[11] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[12] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[13] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[14] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[15] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[16] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[17] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[1] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[2] -1	0	0x00000800 - 0x000008ff (0x100) MX[B]
	[3] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[4] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[5] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[6] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[7] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[8] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[9] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[10] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[11] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[12] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[13] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[14] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[15] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[16] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[17] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x000007ff (0x800) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x000007ff (0x800) MX[B]
	[5] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[6] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[7] -1	0	0x00000800 - 0x000008ff (0x100) MX[B]
	[8] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[9] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[10] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[11] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[12] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[13] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[14] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[15] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[16] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[17] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[18] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[19] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[20] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[21] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[22] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[23] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[24] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) LoadModule: "bitmap"
(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Loading font Bitmap
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.7
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project & the After X-TT Project"
	compiled for 4.3.99.902, module version = 2.1.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Reloading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Loading extension GLX
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.7
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.13.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
(II) Module speedo: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.1
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Speedo
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.2
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.1.0
	ABI class: XFree86 Video Driver, version 0.7
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 6.5.5
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.7
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.4
(II) ATI: ATI driver (version 6.5.5) for chipsets: ati, ativga
(II) R128: Driver for ATI Rage 128 chipsets:
	ATI Rage 128 Mobility M3 LE (PCI), ATI Rage 128 Mobility M3 LF (AGP),
	ATI Rage 128 Mobility M4 MF (AGP), ATI Rage 128 Mobility M4 ML (AGP),
	ATI Rage 128 Pro GL PA (PCI/AGP), ATI Rage 128 Pro GL PB (PCI/AGP),
	ATI Rage 128 Pro GL PC (PCI/AGP), ATI Rage 128 Pro GL PD (PCI),
	ATI Rage 128 Pro GL PE (PCI/AGP), ATI Rage 128 Pro GL PF (AGP),
	ATI Rage 128 Pro VR PG (PCI/AGP), ATI Rage 128 Pro VR PH (PCI/AGP),
	ATI Rage 128 Pro VR PI (PCI/AGP), ATI Rage 128 Pro VR PJ (PCI/AGP),
	ATI Rage 128 Pro VR PK (PCI/AGP), ATI Rage 128 Pro VR PL (PCI/AGP),
	ATI Rage 128 Pro VR PM (PCI/AGP), ATI Rage 128 Pro VR PN (PCI/AGP),
	ATI Rage 128 Pro VR PO (PCI/AGP), ATI Rage 128 Pro VR PP (PCI),
	ATI Rage 128 Pro VR PQ (PCI/AGP), ATI Rage 128 Pro VR PR (PCI),
	ATI Rage 128 Pro VR PS (PCI/AGP), ATI Rage 128 Pro VR PT (PCI/AGP),
	ATI Rage 128 Pro VR PU (PCI/AGP), ATI Rage 128 Pro VR PV (PCI/AGP),
	ATI Rage 128 Pro VR PW (PCI/AGP), ATI Rage 128 Pro VR PX (PCI/AGP),
	ATI Rage 128 GL RE (PCI), ATI Rage 128 GL RF (AGP),
	ATI Rage 128 RG (AGP), ATI Rage 128 VR RK (PCI),
	ATI Rage 128 VR RL (AGP), ATI Rage 128 4X SE (PCI/AGP),
	ATI Rage 128 4X SF (PCI/AGP), ATI Rage 128 4X SG (PCI/AGP),
	ATI Rage 128 4X SH (PCI/AGP), ATI Rage 128 4X SK (PCI/AGP),
	ATI Rage 128 4X SL (PCI/AGP), ATI Rage 128 4X SM (AGP),
	ATI Rage 128 4X SN (PCI/AGP), ATI Rage 128 Pro ULTRA TF (AGP),
	ATI Rage 128 Pro ULTRA TL (AGP), ATI Rage 128 Pro ULTRA TR (AGP),
	ATI Rage 128 Pro ULTRA TS (AGP?), ATI Rage 128 Pro ULTRA TT (AGP?),
	ATI Rage 128 Pro ULTRA TU (AGP?)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI Radeon VE/7000 QY (AGP/PCI), ATI Radeon VE/7000 QZ (AGP/PCI),
	ATI Radeon Mobility M7 LW (AGP),
	ATI Mobility FireGL 7800 M7 LX (AGP),
	ATI Radeon Mobility M6 LY (AGP), ATI Radeon Mobility M6 LZ (AGP),
	ATI Radeon IGP320 (A3) 4136, ATI Radeon IGP320M (U1) 4336,
	ATI Radeon IGP330/340/350 (A4) 4137,
	ATI Radeon IGP330M/340M/350M (U2) 4337,
	ATI Radeon 7000 IGP (A4+) 4237, ATI Radeon Mobility 7000 IGP 4437,
	ATI FireGL 8700/8800 QH (AGP), ATI Radeon 8500 QL (AGP),
	ATI Radeon 9100 QM (AGP), ATI Radeon 8500 AIW BB (AGP),
	ATI Radeon 8500 AIW BC (AGP), ATI Radeon 7500 QW (AGP/PCI),
	ATI Radeon 7500 QX (AGP/PCI), ATI Radeon 9000/PRO If (AGP/PCI),
	ATI Radeon 9000 Ig (AGP/PCI), ATI FireGL Mobility 9000 (M9) Ld (AGP),
	ATI Radeon Mobility 9000 (M9) Lf (AGP),
	ATI Radeon Mobility 9000 (M9) Lg (AGP),
	ATI Radeon 9100 IGP (A5) 5834,
	ATI Radeon Mobility 9100 IGP (U3) 5835,
	ATI Radeon 9200PRO 5960 (AGP), ATI Radeon 9200 5961 (AGP),
	ATI Radeon 9200 5962 (AGP), ATI Radeon 9200SE 5964 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C61 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C63 (AGP), ATI Radeon 9500 AD (AGP),
	ATI Radeon 9500 AE (AGP), ATI Radeon 9600TX AF (AGP),
	ATI FireGL Z1 AG (AGP), ATI Radeon 9700 Pro ND (AGP),
	ATI Radeon 9700/9500Pro NE (AGP), ATI Radeon 9700 NF (AGP),
	ATI FireGL X1 NG (AGP), ATI Radeon 9600 AP (AGP),
	ATI Radeon 9600SE AQ (AGP), ATI Radeon 9600XT AR (AGP),
	ATI Radeon 9600 AS (AGP), ATI FireGL T2 AT (AGP),
	ATI FireGL RV360 AV (AGP), ATI Radeon Mobility 9600 (M10) NP (AGP),
	ATI Radeon Mobility 9600 (M10) NQ (AGP),
	ATI Radeon Mobility 9600 (M11) NR (AGP),
	ATI Radeon Mobility 9600 (M10) NS (AGP),
	ATI FireGL Mobility T2 (M10) NT (AGP),
	ATI FireGL Mobility T2 (M11) NV (AGP), ATI Radeon 9800SE AH (AGP),
	ATI Radeon 9800 AI (AGP), ATI Radeon 9800 AJ (AGP),
	ATI FireGL X2 AK (AGP), ATI Radeon 9800PRO NH (AGP),
	ATI Radeon 9800 NI (AGP), ATI FireGL X2 NK (AGP),
	ATI Radeon 9800XT NJ (AGP)
(II) Primary Device is: PCI 01:00:0
(II) ATI:  Candidate "Device" section "Generic Video Card".
(--) Assigning device section with no busID to primary device
(--) Chipset ATI Radeon Mobility 9200 (M9+) 5C63 (AGP) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x000007ff (0x800) MX[B]
	[5] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[6] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[7] -1	0	0x00000800 - 0x000008ff (0x100) MX[B]
	[8] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[9] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[10] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[11] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[12] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[13] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[14] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[15] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[16] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[17] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[18] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[19] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[20] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[21] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[22] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[23] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[24] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) Loading sub module "radeon"
(II) LoadModule: "radeon"
(II) Loading /usr/X11R6/lib/modules/drivers/radeon_drv.o
(II) Module radeon: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 4.0.1
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.7
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x000007ff (0x800) MX[B]
	[5] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[6] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[7] -1	0	0x00000800 - 0x000008ff (0x100) MX[B]
	[8] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[9] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[10] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[11] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[12] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[13] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[14] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[15] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[16] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[17] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[18] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[19] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[20] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[21] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[22] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[23] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[24] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[25] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[26] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[27] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[28] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[29] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) RADEON(0): MMIO registers at 0xd0100000
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.7
(II) RADEON(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(II) RADEON(0): PCI bus 1 card 0 func 0
(**) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(**) RADEON(0): Option "AGPMode" "4"
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
(II) RADEON(0): initializing int10
(II) RADEON(0): Primary V_BIOS segment is: 0xc000
(--) RADEON(0): Chipset: "ATI Radeon Mobility 9200 (M9+) 5C63 (AGP)" (ChipID = 0x5c63)
(--) RADEON(0): Linear framebuffer at 0xd8000000
(--) RADEON(0): VideoRAM: 32768 kByte (64 bit DDR SDRAM)
(II) RADEON(0): AGP card detected
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.a
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.2.0
	ABI class: XFree86 Video Driver, version 0.7
(II) RADEON(0): I2C bus "DDC" initialized.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 2, Detected Type: 0
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 4, Detected Type: 0
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 3, Detected Type: 0
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 4, Detected Type: 0
(II) RADEON(0): Displays Detected: Monitor1--Type 1, Monitor2--Type 0

(II) RADEON(0): 
(II) RADEON(0): Primary Display == Type 1
(==) RADEON(0): Using gamma correction (1.0, 1.0, 1.0)
(II) RADEON(0): Validating modes on Primary head ---------
(II) RADEON(0): Generic Monitor: Using hsync range of 30.00-60.00 kHz
(II) RADEON(0): Generic Monitor: Using vrefresh range of 50.00-75.00 Hz
(II) RADEON(0): Clock range:  20.00 to 400.00 MHz
(II) RADEON(0): Not using default mode "640x350" (vrefresh out of range)
(II) RADEON(0): Not using default mode "320x175" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x400" (vrefresh out of range)
(II) RADEON(0): Not using default mode "320x200" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "720x400" (vrefresh out of range)
(II) RADEON(0): Not using default mode "360x200" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x480" (vrefresh out of range)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "800x600" (vrefresh out of range)
(II) RADEON(0): Not using default mode "400x300" (vrefresh out of range)
(II) RADEON(0): Not using default mode "1024x768" (vrefresh out of range)
(II) RADEON(0): Not using default mode "512x384" (vrefresh out of range)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1024x768" (hsync out of range)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1152x864" (hsync out of range)
(II) RADEON(0): Not using default mode "576x432" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1280x960" (hsync out of range)
(II) RADEON(0): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1280x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1280x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1280x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1792x1344" (hsync out of range)
(II) RADEON(0): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1792x1344" (hsync out of range)
(II) RADEON(0): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1856x1392" (hsync out of range)
(II) RADEON(0): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1856x1392" (hsync out of range)
(II) RADEON(0): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "576x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1400x1050" (hsync out of range)
(II) RADEON(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1400x1050" (hsync out of range)
(II) RADEON(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1600x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "800x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "2048x1536" (hsync out of range)
(II) RADEON(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "2048x1536" (hsync out of range)
(II) RADEON(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "2048x1536" (hsync out of range)
(II) RADEON(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using mode "1400x1050" (no mode of this name)
(II) RADEON(0): Not using mode "1280x1024" (no mode of this name)
(--) RADEON(0): Virtual size is 1280x960 (pitch 1280)
(**) RADEON(0): *Default mode "1280x960": 108.0 MHz, 60.0 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1280x960"  108.00  1280 1376 1488 1800  960 961 964 1000 +hsync +vsync
(**) RADEON(0): *Default mode "1024x768": 78.8 MHz, 60.1 kHz, 75.1 Hz
(II) RADEON(0): Modeline "1024x768"   78.80  1024 1040 1136 1312  768 769 772 800 +hsync +vsync
(**) RADEON(0): *Default mode "800x600": 49.5 MHz, 46.9 kHz, 75.0 Hz
(II) RADEON(0): Modeline "800x600"   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync
(**) RADEON(0): *Default mode "640x480": 31.5 MHz, 37.5 kHz, 75.0 Hz
(II) RADEON(0): Modeline "640x480"   31.50  640 656 720 840  480 481 484 500 -hsync -vsync
(**) RADEON(0):  Default mode "1152x768": 65.0 MHz, 44.2 kHz, 54.8 Hz
(II) RADEON(0): Modeline "1152x768"   65.00  1152 1178 1314 1472  768 771 777 806 +hsync +vsync
(**) RADEON(0):  Default mode "1024x768": 75.0 MHz, 56.5 kHz, 70.1 Hz
(II) RADEON(0): Modeline "1024x768"   75.00  1024 1048 1184 1328  768 771 777 806 -hsync -vsync
(**) RADEON(0):  Default mode "1024x768": 65.0 MHz, 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1024x768"   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync
(**) RADEON(0):  Default mode "832x624": 57.3 MHz, 49.7 kHz, 74.6 Hz
(II) RADEON(0): Modeline "832x624"   57.28  832 864 928 1152  624 625 628 667 -hsync -vsync
(**) RADEON(0):  Default mode "800x600": 50.0 MHz, 48.1 kHz, 72.2 Hz
(II) RADEON(0): Modeline "800x600"   50.00  800 856 976 1040  600 637 643 666 +hsync +vsync
(**) RADEON(0):  Default mode "800x600": 40.0 MHz, 37.9 kHz, 60.3 Hz
(II) RADEON(0): Modeline "800x600"   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync
(**) RADEON(0):  Default mode "800x600": 36.0 MHz, 35.2 kHz, 56.2 Hz
(II) RADEON(0): Modeline "800x600"   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync
(**) RADEON(0):  Default mode "640x480": 31.5 MHz, 37.9 kHz, 72.8 Hz
(II) RADEON(0): Modeline "640x480"   31.50  640 664 704 832  480 489 491 520 -hsync -vsync
(**) RADEON(0):  Default mode "640x480": 25.2 MHz, 31.5 kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x480"   25.20  640 656 752 800  480 490 492 525 -hsync -vsync
(**) RADEON(0):  Default mode "416x312": 28.6 MHz, 49.7 kHz, 74.7 Hz (D)
(II) RADEON(0): Modeline "416x312"   28.64  416 432 464 576  312 312 314 333 doublescan -hsync -vsync
(**) RADEON(0):  Default mode "400x300": 24.8 MHz, 46.9 kHz, 75.1 Hz (D)
(II) RADEON(0): Modeline "400x300"   24.75  400 408 448 528  300 300 302 312 doublescan +hsync +vsync
(**) RADEON(0):  Default mode "400x300": 25.0 MHz, 48.1 kHz, 72.2 Hz (D)
(II) RADEON(0): Modeline "400x300"   25.00  400 428 488 520  300 318 321 333 doublescan +hsync +vsync
(**) RADEON(0):  Default mode "400x300": 20.0 MHz, 37.9 kHz, 60.3 Hz (D)
(II) RADEON(0): Modeline "400x300"   20.00  400 420 484 528  300 300 302 314 doublescan +hsync +vsync
(==) RADEON(0): DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.7
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.1.0
	ABI class: XFree86 Video Driver, version 0.7
(**) RADEON(0): Using AGP 4x mode
(II) RADEON(0): AGP Fast Write disabled by default
(II) RADEON(0): Depth moves disabled by default
(II) Loading sub module "shadowfb"
(II) LoadModule: "shadowfb"
(II) Loading /usr/X11R6/lib/modules/libshadowfb.a
(II) Module shadowfb: vendor="The XFree86 Project"
	compiled for 4.3.99.902, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(II) RADEON(0): Page flipping disabled
(!!) RADEON(0): For information on using the multimedia capabilities
 of this adapter, please see http://gatos.sf.net.
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0xd0100000 - 0xd010ffff (0x10000) MX[B]
	[1] 0	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B]
	[2] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[3] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[4] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[5] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[6] -1	0	0x00000000 - 0x000007ff (0x800) MX[B]
	[7] -1	0	0xd0201000 - 0xd02017ff (0x800) MX[B]
	[8] -1	0	0xd0201800 - 0xd02018ff (0x100) MX[B]
	[9] -1	0	0x00000800 - 0x000008ff (0x100) MX[B]
	[10] -1	0	0xd0000c00 - 0xd0000dff (0x200) MX[B]
	[11] -1	0	0xd0000000 - 0xd00003ff (0x400) MX[B]
	[12] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[13] -1	0	0xd0100000 - 0xd010ffff (0x10000) MX[B](B)
	[14] -1	0	0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
	[15] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B](OprU)
	[16] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprU)
	[17] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B](OprU)
	[18] 0	0	0x00003000 - 0x000030ff (0x100) IX[B]
	[19] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[20] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[21] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[22] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[23] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[24] -1	0	0x00001880 - 0x000018bf (0x40) IX[B]
	[25] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[26] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[27] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[28] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[29] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[30] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[31] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B](OprU)
	[32] 0	0	0x000003c0 - 0x000003df (0x20) IS[B](OprU)
(==) RADEON(0): Write-combining range (0xd8000000,0x2000000)
(II) RADEON(0): Wrote: rd=12, fd=96, pd=1
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 5, (OK)
drmGetBusid returned ''
(II) RADEON(0): [drm] loaded kernel module for "radeon" driver
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:1:0:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe0884000
(II) RADEON(0): [drm] mapped SAREA 0xe0884000 to 0xb5d8d000
(II) RADEON(0): [drm] framebuffer handle = 0xd8000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [agp] Mode 0x1f000207 [AGP 0x8086/0x3340; Card 0x1002/0x5c63]
(II) RADEON(0): [agp] 8192 kB allocated with handle 0x00000001
(II) RADEON(0): [agp] ring handle = 0xe0000000
(II) RADEON(0): [agp] Ring mapped at 0xb5c8c000
(II) RADEON(0): [agp] ring read ptr handle = 0xe0101000
(II) RADEON(0): [agp] Ring read ptr mapped at 0xb5c8b000
(II) RADEON(0): [agp] vertex/indirect buffers handle = 0xe0102000
(II) RADEON(0): [agp] Vertex/indirect buffers mapped at 0xb5a8b000
(II) RADEON(0): [agp] GART texture map handle = 0xe0302000
(II) RADEON(0): [agp] GART Texture map mapped at 0xb55ab000
(II) RADEON(0): [drm] register handle = 0xd0100000
(II) RADEON(0): [dri] Visual configs initialized
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB GART aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for GART textures
(II) RADEON(0): Memory manager initialized to (0,0) (1280,6553)
(II) RADEON(0): Reserved area from (0,960) to (1280,962)
(II) RADEON(0): Largest offscreen area available: 1280 x 5591
(II) RADEON(0): Will use back buffer at offset 0x960000
(II) RADEON(0): Will use depth buffer at offset 0xe10000
(II) RADEON(0): Will use 13568 kb for textures at offset 0x12c0000
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Scanline Image Writes
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		32 256x256 slots
		16 512x512 slots
(II) RADEON(0): Acceleration enabled
(==) RADEON(0): Backing store disabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using hardware cursor (scanline 962)
(II) RADEON(0): Largest offscreen area available: 1280 x 5587
(**) Option "dpms"
(**) RADEON(0): DPMS enabled
(II) RADEON(0): X context handle = 0x00000001
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete
(II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers
(II) RADEON(0): [drm] Mapped 32 vertex/indirect buffers
(II) RADEON(0): [drm] dma control initialized, using IRQ 11
(II) RADEON(0): [drm] Initialized kernel GART heap manager, 5111808
(II) RADEON(0): Direct rendering enabled
(==) RandR enabled
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Keyboard "Generic Keyboard" handled by legacy driver
(**) Option "Protocol" "ImPS/2"
(**) USB Mouse: Device: "/dev/input/mice"
(**) USB Mouse: Protocol: "ImPS/2"
(**) Option "CorePointer"
(**) USB Mouse: Core Pointer
(**) Option "Device" "/dev/input/mice"
(**) USB Mouse: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) USB Mouse: ZAxisMapping: buttons 4 and 5
(**) USB Mouse: Buttons: 5
(**) Option "Protocol" "ImPS/2"
(**) Touchpad: Device: "/dev/psaux"
(**) Touchpad: Protocol: "ImPS/2"
(**) Option "Device" "/dev/psaux"
(**) Option "Emulate3Buttons" "true"
(**) Touchpad: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Touchpad: ZAxisMapping: buttons 4 and 5
(**) Touchpad: Buttons: 5
(II) XINPUT: Adding extended input device "Touchpad" (type: MOUSE)
(II) XINPUT: Adding extended input device "USB Mouse" (type: MOUSE)
(II) USB Mouse: ps2EnableDataReporting: succeeded
Warning: font renderer for ".pcf" already registered at priority 0
Warning: font renderer for ".pcf.Z" already registered at priority 0
Warning: font renderer for ".pcf.gz" already registered at priority 0
Warning: font renderer for ".snf" already registered at priority 0
Warning: font renderer for ".snf.Z" already registered at priority 0
Warning: font renderer for ".snf.gz" already registered at priority 0
Warning: font renderer for ".bdf" already registered at priority 0
Warning: font renderer for ".bdf.Z" already registered at priority 0
Warning: font renderer for ".bdf.gz" already registered at priority 0
Warning: font renderer for ".pmf" already registered at priority 0
Could not init font path element unix/:7100, removing from list!
(II) Touchpad: ps2EnableDataReporting: succeeded

--=-GJc3uf76Xb1V+84vGpXr--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
