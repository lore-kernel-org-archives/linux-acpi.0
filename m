From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: problem when removing 'ac' module
Date: Tue, 23 Mar 2004 13:00:13 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <406026CD.10104@pca.it>
References: <571ACEFD467F7749BC50E0A98C17CDD803300B9D@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD803300B9D-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

Hi David,

on 03/22/04 03:04, Li, Shaohua wrote:
> Please let me know if below patch helps.
I applied the patch:
=====
gismo:/usr/src# cd linux-2.6.5-rc1-initrd-eciadsl-acpi.scan.c/
gismo:/usr/src/linux-2.6.5-rc1-initrd-eciadsl-acpi.scan.c# cp
/boot/config-2.6.5-rc1 .config
cp: overwrite `.config'? y
`/boot/config-2.6.5-rc1' -> `.config'
gismo:/usr/src/linux-2.6.5-rc1-initrd-eciadsl-acpi.scan.c# patch -p1 <
../kernel/v2.6/acpi-scan.c.diff
patching file drivers/acpi/scan.c
Hunk #1 succeeded at 311 with fuzz 1.
=====

I compiled/installed the new kernel, but I got the same error (module unloaded
in this order > ac, asus_acpi, battery, button, fan, thermal, processor):
=====
Badness in remove_proc_entry at fs/proc/generic.c:664
Call Trace:
 [<c0182b4c>] remove_proc_entry+0x11c/0x160
 [<e114f328>] acpi_ac_remove_fs+0x49/0x6d [ac]
 [<e114f5e9>] acpi_ac_remove+0x86/0xa5 [ac]
 [<c02e9223>] acpi_driver_detach+0x7d/0xdd
 [<c02e9372>] acpi_bus_unregister_driver+0x3d/0x93
 [<e114f63d>] cleanup_module+0x35/0x55 [ac]
 [<c01326fb>] sys_delete_module+0x12b/0x170
 [<c014905a>] do_munmap+0x13a/0x180
 [<c01490e3>] sys_munmap+0x43/0x70
 [<c010935b>] syscall_call+0x7/0xb

Badness in remove_proc_entry at fs/proc/generic.c:664
Call Trace:
 [<c0182b4c>] remove_proc_entry+0x11c/0x160
 [<e1156861>] asus_acpi_exit+0x1d/0x2a [asus_acpi]
 [<c01326fb>] sys_delete_module+0x12b/0x170
 [<c01490e3>] sys_munmap+0x43/0x70
 [<c010935b>] syscall_call+0x7/0xb

Badness in remove_proc_entry at fs/proc/generic.c:664
Call Trace:
 [<c0182b4c>] remove_proc_entry+0x11c/0x160
 [<e11beeb5>] acpi_battery_remove_fs+0x49/0x6d [battery]
 [<e11bf185>] acpi_battery_remove+0x86/0xa5 [battery]
 [<c02e9223>] acpi_driver_detach+0x7d/0xdd
 [<c02e9372>] acpi_bus_unregister_driver+0x3d/0x93
 [<e11bf1d9>] acpi_battery_exit+0x35/0x55 [battery]
 [<c01326fb>] sys_delete_module+0x12b/0x170
 [<c01490e3>] sys_munmap+0x43/0x70
 [<c010935b>] syscall_call+0x7/0xb

Badness in remove_proc_entry at fs/proc/generic.c:664
Call Trace:
 [<c0182b4c>] remove_proc_entry+0x11c/0x160
 [<e11beeb5>] acpi_battery_remove_fs+0x49/0x6d [battery]
 [<e11bf185>] acpi_battery_remove+0x86/0xa5 [battery]
 [<c02e9223>] acpi_driver_detach+0x7d/0xdd
 [<c02e9372>] acpi_bus_unregister_driver+0x3d/0x93
 [<e11bf1d9>] acpi_battery_exit+0x35/0x55 [battery]
 [<c01326fb>] sys_delete_module+0x12b/0x170
 [<c01490e3>] sys_munmap+0x43/0x70
 [<c010935b>] syscall_call+0x7/0xb

Badness in remove_proc_entry at fs/proc/generic.c:664
Call Trace:
 [<c0182b4c>] remove_proc_entry+0x11c/0x160
 [<e116c865>] acpi_button_exit+0x45/0x55 [button]
 [<c01326fb>] sys_delete_module+0x12b/0x170
 [<c01490e3>] sys_munmap+0x43/0x70
 [<c010935b>] syscall_call+0x7/0xb

Badness in remove_proc_entry at fs/proc/generic.c:664
Call Trace:
 [<c0182b4c>] remove_proc_entry+0x11c/0x160
 [<e1230c1a>] acpi_thermal_remove_fs+0x49/0x6d [thermal]
 [<e12310a4>] acpi_thermal_remove+0xce/0xea [thermal]
 [<c02e9223>] acpi_driver_detach+0x7d/0xdd
 [<c02e9372>] acpi_bus_unregister_driver+0x3d/0x93
 [<e12310f5>] acpi_thermal_exit+0x35/0x55 [thermal]
 [<c01326fb>] sys_delete_module+0x12b/0x170
 [<c010935b>] syscall_call+0x7/0xb

Badness in remove_proc_entry at fs/proc/generic.c:664
Call Trace:
 [<c0182b4c>] remove_proc_entry+0x11c/0x160
 [<e121f561>] acpi_processor_remove_fs+0x49/0x6d [processor]
 [<e121fabc>] acpi_processor_remove+0x96/0xc3 [processor]
 [<c02e9223>] acpi_driver_detach+0x7d/0xdd
 [<c02e9372>] acpi_bus_unregister_driver+0x3d/0x93
 [<e121fb8f>] acpi_processor_exit+0x3f/0x5f [processor]
 [<c01326fb>] sys_delete_module+0x12b/0x170
 [<c01490e3>] sys_munmap+0x43/0x70
 [<c010935b>] syscall_call+0x7/0xb
=====

> Thanks,
Your welcome, please let me know if I should make other tests.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAYCbMVAp7Xm10JmkRArCqAJ43xrBTRNPuMP/n2f83ABmfh1P2CQCfdi8o
Tpwpvjt0zB9bFh+/T1lIUUA=
=hTpi
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
