From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: ASUS M6800N: problem when removing 'ac' module
Date: Sat, 20 Mar 2004 12:10:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <405C26C2.70603@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I'm on '2.6.5-rc1 + ACPI DSDT in initrd + eciadsl USB patch' and I get this
message when I 'rmmod ac' or 'modprobe -r ac':
=====
Badness in remove_proc_entry at fs/proc/generic.c:664
Call Trace:
 [<c0182b4c>] remove_proc_entry+0x11c/0x160
 [<e20df328>] acpi_ac_remove_fs+0x49/0x6d [ac]
 [<e20df5e9>] acpi_ac_remove+0x86/0xa5 [ac]
 [<c02e920a>] acpi_driver_detach+0x64/0xbd
 [<c02e9352>] acpi_bus_unregister_driver+0x3d/0x93
 [<e20df63d>] cleanup_module+0x35/0x55 [ac]
 [<c01326fb>] sys_delete_module+0x12b/0x170
 [<c014905a>] do_munmap+0x13a/0x180
 [<c01490e3>] sys_munmap+0x43/0x70
 [<c010935b>] syscall_call+0x7/0xb
=====

and the AC state in the 'GNOME Battery Applet' isn't updated (it still shows I'm
on AC mode).

Please let me know if I should post in the kernel bug database.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAXCbCVAp7Xm10JmkRApXMAJ9DhI7FO2medMeeLMW2hCS2EW15pgCeLm38
0PdFm/YqotMnbnzj7oKh69E=
=zx7S
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
