From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [PATCH] ACPI drop back to pic mode -- linux-2.6.0-test2-acpi-picmode.patch
Date: Thu, 31 Jul 2003 11:20:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307311120.53504.adq_dvb@lidskialf.net>
References: <200307302100.01386.adq_dvb@lidskialf.net> <200307310228.35207.patrick@dreker.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307310228.35207.patrick-G8S07CpUG8qzQB+pC5nmwQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Dreker <patrick-G8S07CpUG8qzQB+pC5nmwQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> System: Asus A7N8X-Deluxe (NForce2), AMD Barton 2800+, Kernel 2.6.0-test2,
> patches as indicated above, CONFIG_ACPI=y, CONFIG_ACPI_BOOT=y,
> CONFIG_X86_UP_APIC=y, CONFIG_X86_UP_IOAPIC=y.
>
> First I noticed something minor during compile:
> drivers/acpi/pic_irq.c: In function acpi_pci_irq_init:
> drivers/acpi/pic_irq.c:519: warning: implicit declaration of function
> 'pic_parse_prt'
> Pretty sure that wasn't there before the patches...

Yeah, my fault.

> After accidentally booting the patched kernel with acpi=off I got the
> following oops very early in the boot process (NOTE: handcopied from the
> screen, no serial console attached):
> EIP: acpi_pci_link_penalties+0x8/0x79
> Call Trace:
> acpi_pci_irq_init+0x8/0x5a
> pci_acpi_init+0x22/0x80
> do_initcalls+0x2b/0xa0
> init_workqueues+0xf/0x30
> init+0x2a/0x180
> init+0x0/0x180
> kernel_thread_helper=0x5/0x10

I've just found a bug in the standard ACPI. Even if you put acpi=off on the 
command line, it still uses ACPI for PCI routing. With the picmode patch, 
this causes the above crash because it assumes ACPI is not used if it is 
disabled.

> I will now have to watch for more lockups, but I am not even sure they are
> in any way related to ACPI/APIC (though it "feels" like the machine is hung
> with all interrupts disabled, and the watchdog does not kick in, Magic
> SysRq doesn't work either)
>
> Addendum: one reboot later: the machine still randomly locks up hard. The
> hardware has been tested (memtest, no overclocking, heatsinks, PSU etc.
> OK...). Any tipps, how I can find out where or when it locks up?

This is with the patch attempting to use ACPI-APIC mode yeah?

Finding out the problems would need a dmesg, and a /proc/acpi/dsdt dump from 
when it fails. Also, an lspci dump from working mode so I know which devices 
are which in the dsdt.




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
