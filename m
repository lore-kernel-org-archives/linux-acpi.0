From: Jamie Guinan <guinan-w0d+SACn59vSUeElwK9/Pw@public.gmane.org>
Subject: RSDT too big
Date: Wed, 8 Oct 2003 17:52:30 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310081743070.18004-100000@gemini.home.net>
Reply-To: guinan-w0d+SACn59vSUeElwK9/Pw@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


With a 2.4.20 SMP kernel, I'm seeing this in my kernel log,

Oct  8 15:37:30 dolly5 kernel: ACPI: Searched entire block, no RSDP was found.
Oct  8 15:37:30 dolly5 kernel: ACPI: RSDP located at physical address c00ea410
Oct  8 15:37:30 dolly5 kernel: ACPI table found: RSDT v1 [COMPAQ CPQ0063  8195.1573]
Oct  8 15:37:30 dolly5 kernel: ACPI: Too big length in RSDT: 124


Here is the code that's reporting it,

  arch/i386/kernel/acpitable.c:

	if (saved_rsdt.header.length > sizeof(saved_rsdt)) {
		printk(KERN_WARNING "ACPI: Too big length in RSDT: %d\n", saved_rsdt.header.length);
		return -ENODEV;
	}

The sizeof(saved_rsdt) is 104.  The code doesn't appear to have changed in 2.4.22.

What could be wrong here?  More entries in the table that the kernel 
doesn't yet know about?  Would it hurt to just continue instead of 
returning -ENODEV?

Additional info,

$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 9
cpu MHz         : 2992.591
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm


$ gdb /boot/vmlinux-2.4.20-18.9smp /proc/kcore
(gdb) x/s 0xc00ea410
0xc00ea410:	 "RSD PTR ,COMPAQ"
(gdb) x/124bx 0xc00ea410
0xc00ea410:	0x52	0x53	0x44	0x20	0x50	0x54	0x52	0x20
0xc00ea418:	0x2c	0x43	0x4f	0x4d	0x50	0x41	0x51	0x00
0xc00ea420:	0x40	0x76	0xff	0x3f	0x00	0x00	0x00	0x00
0xc00ea428:	0x00	0x00	0x00	0x00	0x00	0x00	0x00	0x00
0xc00ea430:	0x00	0x00	0x00	0x00	0x00	0x00	0x00	0x00
0xc00ea438:	0x00	0x00	0x00	0x00	0x00	0x00	0x00	0x00
0xc00ea440:	0x00	0x00	0x00	0x00	0xf0	0x3f	0x78	0x00
0xc00ea448:	0x41	0x40	0x78	0x00	0x00	0x00	0x11	0x00
0xc00ea450:	0x00	0x00	0xff	0xff	0xff	0xff	0xff	0xff
0xc00ea458:	0xff	0xff	0x13	0x00	0x00	0x00	0x78	0x00
0xc00ea460:	0x00	0x00	0x27	0x00	0x00	0x00	0xff	0xff
0xc00ea468:	0xff	0xff	0xff	0xff	0xff	0xff	0x13	0x00
0xc00ea470:	0x00	0x00	0xff	0xff	0xff	0xff	0xff	0xff
0xc00ea478:	0xff	0xff	0xff	0xff	0xff	0xff	0xff	0xff
0xc00ea480:	0xff	0xff	0x10	0x00	0x00	0x00	0xff	0xff
0xc00ea488:	0xff	0xff	0xff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
