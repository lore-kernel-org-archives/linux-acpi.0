From: "Oliver Schindler" <o.schindler-hi6Y0CQ0nG0@public.gmane.org>
Subject: unable to locate RSDP
Date: Mon, 1 Nov 2004 21:14:50 +0100
Message-ID: <E1COiUc-00019j-Un@sc8-sf-mx1.sourceforge.net>
Reply-To: o.schindler-hi6Y0CQ0nG0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi there,
I'm running an emmbedded board EMCore v611 from Arbor.
It contains a VIA VT82c686B chipset and an Award Bios.
I compiled a 2.6.8 Kernel with the stable-acpi-patch from 15-10-
2004.

But all i get on boot time is: "ACPI: unable to locate RSDP"
The documentation of the board says, that APM and ACPI 
(doze/standby/suspend) are supported.

I also tried to several kernel-paramters like acpi=chipset or 
acpi=table without any success.

I also changed the "acpi_find_rsdp()" function in the tables.c to
"acpi_tb_find_rsdp(...)" , but the results stays the same.

I contacted the manufacture of the board for a bios update,
but they didn't answered me at all.

So maybe anyone of you knows help ? Maybe i can modify the
acpi_find_rsdp() - function to scan other areas ?  

So thanks in advance and c.u.

Oliver

Some of the bootup messages:
----------------------------------
Oct 30 01:06:37  kernel: Linux version 2.6.8 (root@linux) (gcc 
version 2.95.3 20010315 (SuSE)) #16 Sat Oct 30 01:04:33 CEST 
2004
Oct 30 01:06:37 kernel: BIOS-provided physical RAM map:
Oct 30 01:06:37 kernel:  BIOS-e820: 0000000000000000 - 
00000000000a0000 (usable)
Oct 30 01:06:37 kernel:  BIOS-e820: 00000000000f0000 - 
0000000000100000 (reserved)
Oct 30 01:06:37 kernel:  BIOS-e820: 0000000000100000 - 
0000000007c00000 (usable)
Oct 30 01:06:37 kernel:  BIOS-e820: 0000000007c00000 - 
0000000008000000 (reserved)
Oct 30 01:06:37  kernel:  BIOS-e820: 00000000ffff0000 - 
0000000100000000 (reserved)
Oct 30 01:06:37 kernel: 124MB LOWMEM available.
Oct 30 01:06:37 kernel: On node 0 totalpages: 31744
Oct 30 01:06:37 kernel:   DMA zone: 4096 pages, LIFO batch:1
Oct 30 01:06:37 kernel:   Normal zone: 27648 pages, LIFO batch:6
Oct 30 01:06:37 kernel:   HighMem zone: 0 pages, LIFO batch:1
Oct 30 01:06:37 kernel: DMI not present.
Oct 30 01:06:37 kernel: ACPI: Unable to locate RSDP
Oct 30 01:06:37 kernel: Built 1 zonelists
Oct 30 01:06:37 kernel: Kernel command line: load_ramdisk=1 
initrd=rootfs.gz root=/dev/ram0 boot=/dev/hdc1 acpi=tables 
apm=off BOOT_IMAGE=kernel 
Oct 30 01:06:37 kernel: Initializing CPU#0

...

Oct 30 01:06:37 kernel: ACPI: Subsystem revision 20041015
Oct 30 01:06:37 kernel: ACPI: Interpreter disabled.


------------------------------------------------------------------------
Every program has at least one bug and can be shortened by at least one
instruction -- from which, by induction, one can deduce that every
program can be reduced to one instruction which doesn't work.

By unknown
------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
